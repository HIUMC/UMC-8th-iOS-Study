//
//  ActionSheet.swift
//  week4Practice
//
//  Created by tokkislove on 4/7/25.
//

import SwiftUI
import PhotosUI

struct ActionSheet: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var images: [UIImage] = []

    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false

    var body: some View {
        VStack(spacing: 20) {
            Button("📷 사진 추가하기") {
                showActionSheet = true
            }

            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                }
            }
        }
        .padding()
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
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItems, maxSelectionCount: 5, matching: .images)
        .onChange(of: selectedItems) { oldItems,newItems in
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        images.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    ActionSheet()
}
