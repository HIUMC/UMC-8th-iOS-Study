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
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    
    @Bindable var viewModel: ReceiptsViewModel = .init()
    
    // 총 금액은 query로
    
    
    // 왼쪽 누르면 삭제: scrollview말고 list와 ondelete
    
    // 영수증 화면 띄우는 건 fullscreencover
    
    var body: some View {
        VStack {
            topNav
                .padding(.horizontal, 20)
            
            if let receipt = viewModel.currentReceipt {
                ReceiptInfoView(receipt: receipt)
            }
            
            Spacer()
        }
        .toolbarVisibility(.hidden)
    }
    
    private var topNav: some View {
        HStack {
            Button(action: {
                router.pop()
            }) {
                Image(systemName: "chevron.left")
            }
            .foregroundStyle(Color("black00"))
            
            Spacer()
            
            Text("전자영수증")
                .font(.mainTextMedium16)
                .foregroundStyle(Color("black00"))
            
            Spacer()
            
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
                    viewModel.performOCR(on: image)
                }
            }
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem, matching: .images)
            .onChange(of: selectedItem) { oldItem, newItem in
                if let item = newItem {
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            viewModel.performOCR(on: image)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ReceiptsView()
}
