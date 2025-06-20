//
//  ReceiptView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/12/25.
//
import Foundation
import SwiftUI
import PhotosUI
import SwiftData

struct ReceiptView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query private var receipts: [ReceiptsModel]

    @State private var viewModel = OCRViewModel()
    @State private var selectedReceipt: ReceiptsModel? = nil
    @State private var isShowingReceiptImage: Bool = false

    @State private var isPhotosPickerPresented: Bool = false
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCameraPicker: Bool = false
    @State private var showActionSheet: Bool = false

    var totalAmount: Int {
        receipts.reduce(0) { $0 + $1.totalAmount }
    }

    func reloadSelectedReceipt(with id: UUID) {
        if let latest = receipts.first(where: { $0.id == id }) {
            selectedReceipt = latest
        }
    }

    func handleImageTap(for receipt: ReceiptsModel) {
        selectedReceipt = receipt
        isShowingReceiptImage = true
    }

    var body: some View {
        VStack {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("black03"))
                }
                Spacer()
                Text("전자영수증")
                    .foregroundStyle(Color.black01)
                    .font(.mainTextMedium16)
                Spacer()
                Button(action: { showActionSheet = true }) {
                    Image(systemName: "plus")
                        .foregroundColor(Color("black03"))
                }
            }
            .padding()
          Text("Other")
                .font(.mainTextBold24)
                .foregroundColor(Color("black03"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)

            VStack {
                HStack {
                    Text("총")
                        .font(.mainTextRegular18)
                        .foregroundStyle(Color.black01)
                    Text("\(receipts.count)건")
                        .font(.mainTextRegular18)
                        .foregroundStyle(Color.brown01)
                    Spacer()
                    Text("사용합계")
                        .font(.mainTextRegular18)
                        .foregroundStyle(Color.black01)
                    Text("\(totalAmount)원")
                        .font(.mainTextRegular18)
                        .foregroundStyle(Color.brown01)
                }
                .padding()
              

                ReceiptListView(
                    receipts: receipts,
                    onImageTap: { receipt in
                        handleImageTap(for: receipt)
                    }
                )
            }

            .confirmationDialog("사진을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
                Button("앨범에서 가져오기") { isPhotosPickerPresented = true }
                Button("카메라로 촬영하기") { showCameraPicker = true }
                Button("취소", role: .cancel) {}
            }

            .photosPicker(isPresented: $isPhotosPickerPresented, selection: $selectedItems, maxSelectionCount: 5, matching: .images)

            .onChange(of: selectedItems) {
                for item in selectedItems {
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            viewModel.addImage(image, context: context)
                        }
                    }
                }
            }

            .sheet(isPresented: $showCameraPicker) {
                CameraPicker { image in
                    viewModel.addImage(image, context: context)
                }
            }

            .fullScreenCover(isPresented: $isShowingReceiptImage) {
                if let receipt = selectedReceipt {
                    if let imageModel = receipt.image,
                       let data = imageModel.photo,
                       let image = UIImage(data: data) {
                        ReceiptImage(image: image)
                    } else {
                        Text("이미지 데이터 없음")
                    }
                } else {
                    Text("selectedReceipt 설정 안됨")
                }
            }




            .onAppear {
                viewModel.context = context
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("white00"))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    struct ReceiptRowView: View {
        let receipt: ReceiptsModel
        var onImageTap: () -> Void

        var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            return formatter.string(from: receipt.createdAt)
        }

        var body: some View {
            VStack(alignment: .leading) {
                Text(receipt.store)
                    .foregroundStyle(Color("black02"))
                    .font(.mainTextSemiBold18)
                    .padding(.horizontal)
                HStack {
                    Text(formattedDate)
                        .foregroundStyle(Color("gray03"))
                        .font(.mainTextMedium16)
                    Spacer()
                    Button(action: onImageTap) {
                        Image("greenDollar")
                    }
                }
                .padding(.horizontal)
                Text("\(receipt.totalAmount)원")
                    .foregroundStyle(Color.brown02)
                    .padding(.horizontal)
                    .font(.mainTextSemiBold18)
                Divider()
            }
        }
    }

    struct ReceiptListView: View {
        let receipts: [ReceiptsModel]
        let onImageTap: (ReceiptsModel) -> Void

        var body: some View {
            ScrollView {
                ForEach(receipts, id: \.id) { receipt in
                    ReceiptRowView(receipt: receipt, onImageTap: {
                        onImageTap(receipt)
                    })
                }
            }
        }
    }
}

#Preview {
    ReceiptView()
}
