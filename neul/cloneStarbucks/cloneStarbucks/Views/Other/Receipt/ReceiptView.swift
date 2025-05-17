//
//  ReceiptView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/8/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ReceiptView: View {
    private var viewModel: ReceiptViewModel = .init()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var images: [UIImage] = []
    @State private var selectedReceipt: ReceiptModel? = nil

    @State private var showCamera = false
    @State private var showImage = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \ReceiptModel.createdAt, order: .reverse) var receipts: [ReceiptModel]
    
    var body: some View {
        ZStack {
            Color.white01
            VStack {
                navBar
                topView
                receiptList
                Spacer()
                
            }
            .confirmationDialog("사진을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
                Button("앨범에서 가져오기") {
                    showPhotosPicker = true
                }

                Button("카메라로 촬영하기") {
                    showCamera = true
                }

                Button("취소", role: .cancel) {}
            }
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem, matching: .images)
            
            .sheet(isPresented: $showCamera) {
                CameraPicker { image in
                    if let data = image.jpegData(compressionQuality: 1.0) {
                        Task {
                            viewModel.addNewReceipt(from: data)
                        }
                    }
                }
            }
            .fullScreenCover(item: $selectedReceipt) { receipt in
                ReceiptImageViewer(receipt: receipt)
            }
            .onChange(of: selectedItem) { _, newItem in
                if let item = newItem {
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            viewModel.addNewReceipt(from: data)

                        }
                    }
                }
            }
            

        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.context = context
        }
        
    }
    
    
    private var navBar: some View {
        HStack {
            CustomNavBackButton()
            Spacer()
            Text("전자영수증")
                .font(.MainTextMedium16)
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
        .padding(.top, 60)
        .padding(.bottom, 22)
        .background(Color.white)
    }
    
    private var topView: some View {
        HStack {
            Text("총")
                .foregroundStyle(.black)
                .font(.MainTextRegular18)
            Text("\(receipts.count)건")
                .foregroundStyle(.brown01)
                .font(.MainTextSemiBold18)
            Spacer()
            Text("사용합계")
                .foregroundStyle(.black)
                .font(.MainTextRegular18)
            Text("\(receipts.reduce(0) { $0 + $1.totalAmount })")
                .foregroundStyle(.brown01)
                .font(.MainTextSemiBold18)
            
        }
        .padding(.horizontal, 19)
        .padding(.top, 12)
    }
    
    @ViewBuilder
    private var receiptList: some View {
        if receipts.isEmpty {
            Text("저장된 영수증이 없어요!")
                .padding(.vertical, 50)
        } else {
            
            List {
                ForEach(receipts, id: \.id) { receipt in
                    ReceiptInfo(receipt: receipt) {
                        selectedReceipt = receipt
                    }
                }
                .onDelete(perform: deleteReceipt)
            }
                .listStyle(.plain)
            
                
            }
    }
    
    
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

struct ReceiptView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ReceiptView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
