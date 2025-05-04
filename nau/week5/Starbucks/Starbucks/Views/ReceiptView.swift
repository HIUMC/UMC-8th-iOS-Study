//
//  ReceiptView.swift
//  Starbucks
//
//  Created by nau on 4/8/25.
//

import SwiftUI
import PhotosUI

struct ReceiptView: View {
    @Environment(NavigationRouter.self) var router
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false

    @State var viewModel = OCRViewModel()
    
    @State private var showReceiptImage = false //이미지 팝업 제어 변수
    
    var body: some View {
        ZStack {
            VStack {
                navigationView
                
                ZStack {
                    Color(.white01).ignoresSafeArea()
                    
                    VStack {
                        
                        Spacer().frame(height: 15)
                        
                        totalPriceView
                        
                        receiptTableView
                        
                    }.padding(.horizontal, 19)
                }
            }
            
            if let image = viewModel.selectedReceiptImage, showReceiptImage {
                ImageView(image: image, show: $showReceiptImage)
            }
            //fullScreenCover로 하니까 뒤에 뷰는 안보여서..
            /*.fullScreenCover(isPresented: $showReceiptImage) {
             if let image = viewModel.selectedReceiptImage {
             ImageView(image: image)
             } else {
             Text("이미지가 없습니다")
             }
             }*/
        }
        //영수증 버튼 눌렀을 때 사진 시트로 보여주기
        .navigationBarBackButtonHidden(true)
        .confirmationDialog("사진을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("앨범에서 가져오기") {
                showPhotosPicker = true
            }
            
            Button("카메라로 촬영하기") {
                showCamera = true
            }
            
            Button("취소", role: .cancel) {}
        }
        .fullScreenCover(isPresented: $showCamera) {
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
    }
    
    private var navigationView: some View {
        HStack {
            Button(action: {
                router.pop()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            })
            
            Spacer()
            
            Text("전자영수증")
                .font(.mainTextMedium16)
            
            Spacer()
            
            Button(action: {
                showActionSheet = true
            }, label: {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
            })
        }
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity, maxHeight: 40)
    }
    
    private var totalPriceView: some View {
        HStack {
            Group {
                Text("총")
                Text("\(viewModel.receiptCount)건")
                    .foregroundStyle(.brown01)
                
                Spacer()
                
                Text("사용합계")
                Text("\(viewModel.sum)원")
                    .foregroundStyle(.brown01)
            }.font(.mainTextSemibold18)
        }
    }
    
    private var receiptTableView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.currentReceipts) { receipt in
                    ReceiptInfoView(receipt: receipt)
                        /*
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button(action: {
                                if let index = viewModel.currentReceipts.firstIndex(where: { $0.id == receipt.id }) {
                                    viewModel.currentReceipts.remove(at: index)
                                    viewModel.sum -= receipt.totalAmount
                                }
                            }, label: {
                                Text("삭제")
                            }).tint(.red)
                         
                        }
                         */
                } /*else {
                    ProgressView("OCR 처리 중...")
                }*/
            }
        }
    }
    
    private func ReceiptInfoView(receipt: ReceiptModel) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer().frame(height: 7)
            
            Text("\(receipt.store)")
                .font(.mainTextSemibold18)
            
            HStack {
                Text("\(receipt.date)")
                    .font(.mainTextMedium16)
                    .foregroundStyle(.gray03)
                
                Spacer()
                
                Button(action: {
                    if let image = receipt.receiptImage {
                        viewModel.selectedReceiptImage = image
                        showReceiptImage.toggle()
                    }
                }, label: {
                    Image(.receiptGo)
                })
            }
            
            Text("\(receipt.totalAmount)원")
                .font(.mainTextSemibold18)
                .foregroundStyle(.brown02)
            
            Spacer().frame(height: 3)
            
            Divider()
        }
    }
    
    private func ImageView(image: UIImage, show: Binding<Bool>) -> some View {
        return ZStack {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            ZStack(alignment: .topTrailing) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
                Button(action: {
                    showReceiptImage.toggle()
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundStyle(.gray04)
                })
                .padding(.trailing, 10)
                .padding(.top, 10)
            }
        }
    }
}


#Preview {
    ReceiptView()
}
