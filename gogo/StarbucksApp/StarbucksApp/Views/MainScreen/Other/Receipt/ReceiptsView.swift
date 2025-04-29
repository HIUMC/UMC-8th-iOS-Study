
//  ReceiptView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/24/25.





import SwiftUI
import PhotosUI

struct ReceiptView: View {
    @EnvironmentObject var router: NavigationRouter
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false

    @State var viewModel = ReceiptsViewModel() ///viewModel이 receipt 객체!
    
    @State private var showReceiptImage = false //이미지 popup  변수
    
    //MARK: -메인 뷰,상단부터 navigationView,totalPriceView,receiptListView순~
    var body: some View {
        ZStack {
            VStack {
                navigationView
                
                ZStack {
                    Color(.white01).ignoresSafeArea()
                    
                    VStack {
                        
                        Spacer().frame(height: 15)
                        
                        totalPriceView
                        
                        receiptListView
                        
                    }.padding(.horizontal, 19)
                }
            }
            
            if let image = viewModel.selectedReceiptImage, showReceiptImage {
                ImageView(image: image, show: $showReceiptImage)
            }
        
        }
        //눌렀을때 영수증 sheet로 보여주기
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
    
//MARK: -상단 네비게이션 바
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
                .font(.PretendardMedium16)
            
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
//MARK: -총 금액 나타냄. 사용합계.
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
            }.font(.PretendardSemiBold18)
        }
    }
    
    //MARK: -영수증들 scrollView. 안에 렌더링시에만 보이게 LazyVStack
    private var receiptListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.currentReceipts) { receipt in
                    ReceiptInfoView(receipt: receipt)
                }
            }
        }
    }
    
    //MARK: - 영수증 정보 뷰.
    private func ReceiptInfoView(receipt: ReceiptModel) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Spacer().frame(height: 5)
            
            Text("\(receipt.store)")
                .font(.PretendardSemiBold18)
            
            HStack {
                Text("\(receipt.date)")
                    .font(.PretendardMedium16)
                    .foregroundStyle(.gray03)
                
                Spacer()
                
                Button(action: {
                    if let image = receipt.receiptImage {
                        viewModel.selectedReceiptImage = image
                        showReceiptImage.toggle()
                    }
                }, label: {
                    Image(.bill2)
                })
            }
            
            Text("\(receipt.totalAmount)원")
                .font(.PretendardSemiBold18)
                .foregroundStyle(.brown02)
            
            Spacer().frame(height: 3)
            
            Divider()
        }
    }
    
    //MARK: -영수증 image 누르면 영수증 View(우측 상단에 x)
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
