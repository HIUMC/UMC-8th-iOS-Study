//
//  ReceiptView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/8/25.
//
/*import SwiftUI

struct ReceiptView: View{
    var body: some View{
        Text("전자영수증")
    }
}
*/

import SwiftUI

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = ReceiptViewModel()

    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showActionSheet = false
    @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary

    var body: some View {
        VStack(spacing: 0) {
            topButtonView
                .padding(.top, 15)

            Text("Other")
                .font(.mainTextBold24)
                .foregroundColor(Color("black03"))
                .padding(.leading, 24)

            HStack(spacing: 0) {
                (
                    Text("총 ")
                        .foregroundColor(Color("black03")) +
                    Text("\(viewModel.totalCount)건")
                        .foregroundColor(Color("brown01"))
                )
                .font(.mainTextSemiBold18)

                Spacer()

                Text("사용합계 \(viewModel.totalAmount.formatted())원")
                    .foregroundColor(Color("brown01"))
                    .font(.mainTextSemiBold18)
            }
            .padding(.horizontal, 24)
            .padding(.top, 10)

            List {
                ForEach(viewModel.receipts) { receipt in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(receipt.storeName)
                                .font(.headline)
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "dollarsign.square.fill")
                                .foregroundColor(Color("green01"))
                        }

                        Text(receipt.date.formatted(date: .numeric, time: .shortened))
                            .font(.mainTextMedium16)
                            .foregroundColor(Color("gray02"))

                        Text("\(receipt.amount.formatted())원")
                            .foregroundColor(Color("brown02"))
                            .font(.mainTextSemiBold18)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(.plain)
        }
        .confirmationDialog("영수증 사진을 선택하세요", isPresented: $showActionSheet) {
            Button("카메라") {
                imageSource = .camera
                showImagePicker = true
            }
            Button("앨범에서 선택") {
                imageSource = .photoLibrary
                showImagePicker = true
            }
            Button("취소", role: .cancel) {}
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: imageSource, selectedImage: $selectedImage)
        }
    }

    private var topButtonView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color("black03"))
                    .frame(width: 15, height: 15)
            }

            Spacer()

            Text("전자영수증")
                .foregroundColor(Color("black03"))

            Spacer()

            Button(action: {
                showActionSheet = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(Color("black03"))
                    .frame(width: 15, height: 15)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ReceiptView()
        .modelContainer(for: Receipt.self, inMemory: true) // 💡 SwiftData용 in-memory 컨테이너
}
