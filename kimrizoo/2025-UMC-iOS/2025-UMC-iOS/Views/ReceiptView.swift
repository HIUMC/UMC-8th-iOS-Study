//
//  ReceiptView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/10/25.
//

import SwiftUI
import PhotosUI

struct ReceiptView: View {
    @StateObject private var viewModel: OCRViewModel = OCRViewModel()
    
    var body: some View {
        VStack {
            TopNavigationBar(viewModel: viewModel)
            
            ScrollView {
                if !viewModel.recognizedText.isEmpty {
                    Divider()
                    Text("📝 OCR 결과")
                        .font(.headline)
                    ScrollView {
                        Text(viewModel.recognizedText)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.secondarySystemBackground))
                    }
                    .frame(height: 200)
                } else {
                    Text("추출 결과 값 없음")
                }
            }
        }
        .background(Color.otherBackground)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ReceiptView()
}

//-----------------------------------------
// 탑 네비게이션 뷰
private struct TopNavigationBar: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false

    @ObservedObject var viewModel: OCRViewModel

    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }

            Spacer()

            Text("전자영수증")
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            Button(action: {
                showActionSheet = true
            }) {
                Image(systemName: "plus")
            }
            .foregroundStyle(.black)
            .confirmationDialog("영수증을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
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
                    viewModel.addImage(image) // ✅ OCR 처리 시작
                }
            }
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItems, maxSelectionCount: 5, matching: .images)
            .onChange(of: selectedItems) { oldItems, newItems in
                for item in newItems {
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            viewModel.addImage(image) // ✅ OCR 처리 시작
                        }
                    }
                }
            }
        }
        .padding()
        .background(.white)
    }
}

