//
//  ReceiptsView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import SwiftUI
import PhotosUI

struct ReceiptsView: View {
    @EnvironmentObject private var router: NavigationRouter
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    
    @Bindable var viewModel: OCRViewModel = .init()
    
    // 총 금액은 query로
    
    // 왼쪽 누르면 삭제: scrollview말고 list와 ondelete
    
    // 엉수증 화면 띄우는 건 fullscreencover
    
    var body: some View {
        VStack {
            if let receipt = viewModel.currentReceipt {
                ReceiptInfoView(receipt: receipt)
            } else {
                Text("OCR 처리 중...")
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.pop()
                }) {
                    Image(systemName: "chevron.left")
                }
                .foregroundStyle(Color("black00"))
            }
            
            ToolbarItem(placement: .principal) {
                Text("전자영수증")
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("black00"))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showActionSheet = true
                }) {
                    Image(systemName: "plus")
                }
                .foregroundStyle(Color("black00"))
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
                    OCRCameraPicker { image in
                        viewModel.addImage(image)
                    }
                }
                .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItems, maxSelectionCount: 5, matching: .images)
                .onChange(of: selectedItems) { oldItems, newItems in
                    for item in newItems {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                viewModel.addImage(image)
                            }
                        }
                    }
                }
            }
        })
    }
}

#Preview {
    ReceiptsView()
}
