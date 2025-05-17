//
//  ReceiptView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/7/25.
//


// 결제금액 왜 안 뜨지.... ..

import SwiftUI
import Observation
import PhotosUI

struct ReceiptView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showActionSheet: Bool = false
    //@Binding var showActionSheet: Bool
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showPhotosPicker = false
    @State private var selectedImageForPreview: UIImage? = nil
    @State private var showFullScreen = false
    
    @Bindable var viewModel: ReceiptsViewModel = .init()
    
    var body: some View {
        ZStack {
            Color.bg
            VStack {
                VStack(alignment: .leading, spacing: 0) { //v3
                    NavBarView (dismiss: {
                        dismiss()
                    }, plusButtonTapped: {
                        showActionSheet = true
                    })
                    //.frame(width: 420, height: CGFloat(70))
                    
                    receiptHeaderSummaryView
                    Spacer()
                    
                    if !viewModel.ocrResults.isEmpty {
                        ScrollView {
                            VStack(spacing: 16) {
                                receiptListView
                            }
                            .padding(.horizontal, 19)
                            .padding(.top, 16)
                        }
                        
                    }
                    
                    
                } // v3
                
                //.padding(.horizontal, 30) // 양옆
                .navigationBarBackButtonHidden(true) // 기본 뒤로가기 버튼 숨기기
                //.toolbar(content: receiptToolbar)
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
                        viewModel.addOCRResult(from: image)
                    }
                }
                .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItems, maxSelectionCount: 5, matching: .images)
                // .onChange(of: selectedItems) { oldItems, newItems in
                //.onChange(of: selectedItems) { newItems in
                .onChange(of: selectedItems, initial: false) { oldItems, newItems in
                    for item in newItems {
                        Task {
                            if let data = try? await item.loadTransferable(type: Data.self),
                               let image = UIImage(data: data) {
                                viewModel.addImage(image)
                                viewModel.addOCRResult(from: image)
                                //viewModel.startOCR(from: image)
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showFullScreen) {
                if let image = selectedImageForPreview {
                    ZStack(alignment: .topTrailing) {
                        Color.black.ignoresSafeArea()
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        Button(action: {
                            showFullScreen = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .padding()
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
    
    private var receiptHeaderSummaryView: some View {
        HStack {
            HStack {
                Text("총")
                    .font(.PretendardMedium18)
                //Text("1건")
                Text("\(viewModel.ocrResults.count)건")
                    .font(.PretendardMedium18)
                    .foregroundStyle(Color.brown01)
                    .fontWeight(.semibold)
            }
            Spacer()
            HStack {
                Text("사용합계")
                    .font(.PretendardMedium18)
                //Text("6,500")
                Text("\(viewModel.ocrResults.map { $0.receipt.totalAmount }.reduce(0, +).formattedWithComma())") //map함수, reduc(0,+) .. 오호..
                    .font(.PretendardMedium18)
                    .foregroundStyle(Color.brown01)
                    .fontWeight(.semibold)
            }
        }
        .padding(.horizontal, 17)
    }

    /*
    @ToolbarContentBuilder
    
    
    private var receiptToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
            }
        }

        ToolbarItem(placement: .principal) {
            Text("전자영수증")
                .font(.PretendardMedium16)
                .foregroundStyle(Color.black00)
        }

        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                showActionSheet = true
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.black)
            }
        }
    }
     */

    @ViewBuilder
    private var receiptListView: some View {
        ForEach(viewModel.ocrResults, id: \.id) { result in
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(result.receipt.store)")
                        .font(.headline)
                    Text(result.receipt.createdAt.formattedString())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("₩\(result.receipt.totalAmount.formattedWithComma())원")
                        .font(.headline)
                        .foregroundColor(.brown01)
                    Rectangle() // 이 부분 고정된 거 빼니까 괜찮아지네..
                        .frame(width: .infinity)
                        .frame(height: 0.7)
                        .foregroundStyle(Color.signupGray)
                        .padding(.top, 10)
                }
                Spacer()
                Image("receiptButton")
                    .frame(width: 16, height: 20)
                    .onTapGesture {
                        selectedImageForPreview = result.image
                        showFullScreen = true
                    }
            }
        }
    }

    
    
    struct GetImage: View {
        @Binding var images: [UIImage]
        var body: some View {
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
    }
    
    
    
    private var tabView: some View {
        TabView(selection: $viewModel.selectedSegment, content: {
            ForEach(ReceiptSegment.allCases, id: \.id) { segment in
                VStack(spacing: 10) {
                    Image(segment.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 490)
                    
                    if viewModel.selectedSegment == segment {
                        if let receipt = viewModel.currentReceipt {
                            ReceiptInfoView(receipt: receipt)
                        } else {
                            ProgressView("OCR 처리 중...")
                        }
                    }
                }
                .tag(segment)
                /* 세그먼트의 탭 화면이 등장할 때 OCR 추출이 돼야 하기 때문에 task로 작성합니다. */
                .task {
                    viewModel.startOCR(segment)
                }
            }
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: self)
    }
}

extension Int {
    func formattedWithComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

#Preview {
    ReceiptPreviewWrapper()
}

struct ReceiptPreviewWrapper: View {
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            ReceiptView()
        }
    }
}
