//
//  ReceiptView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/13/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ReceiptView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Query(sort: \ReceiptsModel.createdAt) private var receipts: [ReceiptsModel]
    
    @State private var viewModel: OCRViewModel = .init()
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    
    var body: some View {
        VStack {
            navBar
            
            let total = receipts.reduce(0) { $0 + $1.totalAmount }
            
            HStack(spacing: 3) {
                
                Text("총")
                    .foregroundStyle(.black01)
                    .font(.mainTextRegular18)
                
                Text("\(receipts.count)건")
                    .foregroundStyle(.brown01)
                    .font(.PretendardSemiBold18)
                
                Spacer()
                
                Text("사용합계")
                    .foregroundStyle(.black01)
                    .font(.mainTextRegular18)
                
                Text("\(total.formatted(.number.grouping(.automatic)))원")
                    .foregroundStyle(.brown01)
                    .font(.PretendardSemiBold18)
            }
            
            .padding(.vertical, 10)
            .padding(.horizontal, 19)
            
            
            List {
                ForEach(receipts, id: \.id) { receipt in
                    ReceiptList(model: receipt)
                        
                }
            }
            
            
        }
        .navigationBarHidden(true)
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
        .onAppear {
            viewModel.context = context
        }
    }
    
    private var navBar: some View {
        NavigationStack{
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black01)
                }
                
                Spacer()
                
                Text("전자영수증")
                    .font(.mainTextMedium16)
                
                Spacer()
                
                Button(action: {
                    showActionSheet = true
                }) {
                    Image(systemName: "plus")
                        .foregroundStyle(.black01)
                }
            }
            .padding()
        }
}

}

#Preview {
    NavigationStack {
        ReceiptView()
    }
}

