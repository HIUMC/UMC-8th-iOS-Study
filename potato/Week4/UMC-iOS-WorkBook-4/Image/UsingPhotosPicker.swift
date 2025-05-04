//
//  UsingPhotosPicker.swift
//  UMC-iOS-WorkBook-4
//
//  Created by 곽은채 on 4/7/25.
//

import SwiftUI
import PhotosUI

struct UsingPhotosPicker: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []

    var body: some View {
        VStack(spacing: 20) {
            PhotosPicker("📁 사진 선택하기", selection: $selectedItems, maxSelectionCount: 5, matching: .images)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedImages, id: \.self) { image in
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
        .onChange(of: selectedItems) { oldItems, newItems in
            selectedImages.removeAll()
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImages.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    UsingPhotosPicker()
}
