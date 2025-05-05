//
//  ReceiptView.swift
//  Starbucks
//
//  Created by 박정환 on 4/8/25.
//

import SwiftUI
import PhotosUI
import SwiftData
import Observation

struct ReceiptsView: View {
    @Bindable var receiptsviewModel: ReceiptsViewModel = .init()
    
    @State private var selectedItems: PhotosPickerItem? = nil
    @State private var images: [UIImage] = []
    @State private var selectedReceipts: ReceiptsModel? = nil
    
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \ReceiptsModel.createdAt, order: .reverse) var receipts: [ReceiptsModel]
    
    var body: some View {
        VStack{
            navBar
            topView
            receiptList
            Spacer()
        }
        .background(Color.white01)
        .confirmationDialog("사진을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
                    Button("앨범에서 가져오기") {
                        showPhotosPicker = true
                    }
                    Button("카메라로 촬영하기") {
                        showCamera = true
                    }
                    Button("취소", role: .cancel) {}
                }
                .sheet(isPresented: $showCamera) {
                    CameraPicker { image in
                        images.append(image)
                    }
                }
                .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItems, matching: .images)
        
                .onChange(of: selectedItems) { oldItems, newItems in
                                if let item = newItems {
                                    Task {
                                        if let data = try? await item.loadTransferable(type: Data.self) {
                                            receiptsviewModel.addNewReceipt(from: data)

                                        }
                                    }
                                }
                            }
        
                .onAppear {
                    receiptsviewModel.context = context
                }
    }
    
    private var navBar: some View {
        HStack {
            CustomBackButton()
            Spacer()
            Text("전자영수증")
                .font(.mainTextMedium16)
                .foregroundStyle(.black)
            Spacer()
            Button {
                showActionSheet = true
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 15, height: 15)
            }
        }
        .padding(.horizontal, 13)
        .padding(.bottom, 23)
        .background(Color.white)
    }
    
    private var topView: some View {
        HStack {
            Text("총")
                .font(.mainTextRegular18)
            Text("\(receipts.count)건")
                .font(.mainTextSemiBold18)
            Spacer()
            Text("사용합계")
                .font(.mainTextRegular18)
            Text("\(receipts.reduce(0) { $0 + $1.totalAmount })")
                .foregroundStyle(.brown01)
                .font(.mainTextSemiBold18)
        }
        .padding(.horizontal, 13)
        .padding(.top, 16)
    }
    
    //영수증 저장 리스트
    @ViewBuilder
    private var receiptList: some View {
            if receipts.isEmpty {
                Text("저장된 영수증이 없어요!")
                    .padding(.vertical, 50)
            } else {
                List {
                    ForEach(receipts, id: \.id) { receipt in
                        ReceiptInfo(receipt: receipt) {
                            selectedReceipts = receipt
                        }
                    }
                    .onDelete(perform: deleteReceipt)
                }
                    .listStyle(.plain)
            }
    }
    
    struct ReceiptInfo: View {
        var receipt: ReceiptsModel
        var action: () -> Void
        
        var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 9) {
                        Text(receipt.store)
                            .font(.mainTextSemiBold18)
                            .foregroundStyle(.black)
                        Text(receipt.date)
                            .font(.mainTextMedium16)
                            .foregroundStyle(.gray03)
                        Text("\(receipt.totalAmount)원")
                            .font(.mainTextSemiBold18)
                            .foregroundStyle(.brown02)
                    }
                    .padding(.bottom, 14)
                    
                    Spacer()
                    
                    Button(action: {
                        action()
                    }, label: {
                        Image("first")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 16, height: 20)
                    })
                }
                Divider()
            }
            .padding(.horizontal, 19)
        }
    }
    
    
    //영수증 삭제
    func deleteReceipt(at offsets: IndexSet) {
        for index in offsets {
            let receipt = receipts[index]
            
            // 이미지도 함께 삭제하려면
            if let image = receipt.image {
                context.delete(image)
            }
            context.delete(receipt)
        }

        try? context.save()
    }
    
}

struct ReceiptsView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ReceiptsView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
