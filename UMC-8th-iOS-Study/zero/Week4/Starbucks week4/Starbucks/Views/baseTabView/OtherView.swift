//
//  OtherView.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//
import Foundation
import SwiftUI
import PhotosUI
import Vision

struct OtherView: View {
    @State private var path = NavigationPath()
    
    @AppStorage("newID") private var nickname: String = ""
    
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                TopView
                ContentView
            }
            .navigationDestination(for: String.self) { value in
                if value == "receipt" {
                    ReceiptView()
                }
            }
        }
    }
    
    private var TopView: some View {
        HStack {
            Text("Other")
                .font(.PretendardExtrabold24)
                .foregroundStyle(.black)
            
            Spacer().frame(width: 255)
            
            Button(action: {
                print("로그아웃")
            }, label:{
                Image("logout")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(.black)
            })
        }//HStack End
        .background(.white)
    }//TopView End
    
    private var ContentView: some View {
        VStack {
            Spacer().frame(height:41)
            
            infoView
            
            Spacer()
            
            payView
            
            Spacer()
            
            supportView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 41)
        .background(.otherback)
    }
    
    private var infoView: some View {
        InfoSection(nickname: nickname, goToReceipt: goToReceipt)
    }
    
    struct InfoSection: View {
        let nickname: String
        let goToReceipt: () -> Void

        var body: some View {
            VStack {
                HStack {
                    Text(nickname.isEmpty ? "(작성한 닉네임)" : nickname)
                        .foregroundStyle(.login)
                        .font(.PretendardSemibold24)
                    Text("님")
                        .foregroundStyle(.black)
                        .font(.PretendardSemibold24)
                }

                VStack {
                    Text("환영합니다! 🙌🏻")
                        .foregroundStyle(.black)
                        .font(.PretendardSemibold24)
                }

                Spacer().frame(height: 25)

                HStack {
                    InfoButton(image: .starhistory, title: "별 히스토리") {
                        print("별 히스토리")
                    }

                    InfoButton(image: .myreceipt, title: "전자영수증", action: goToReceipt)

                    InfoButton(image: .my, title: "나만의 메뉴") {
                        print("나만의 메뉴")
                    }
                }
            }
        }
    }

    @MainActor
    private func goToReceipt() {
        print("전자영수증")
        path.append("receipt")
    }
    
    struct InfoButton: View {
        let image: ImageResource
        let title: String
        var action: () -> Void = {}

        var body: some View {
            Button(action: action) {
                InfoButtonContent(image: image, title: title)
            }
        }
    }

    struct InfoButtonContent: View {
        let image: ImageResource
        let title: String

        var body: some View {
            VStack(spacing: 4) {
                Spacer().frame(height: 19)
                Image(image)
                Text(title)
                    .font(.PretendardSemibold16)
                    .foregroundStyle(Color.black)
                Spacer().frame(height: 19)
            }
            .frame(width: 102, height: 108)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
        }
    }
    
    private var payView: some View {
        VStack(alignment: .leading) {
            Text("Pay")
                .font(.PretendardSemibold18)
                .foregroundStyle(.black)
            Spacer().frame(height: 8)
            
            HStack {
                listItem(image: .card, title: "스타벅스 카드 등록")
                Spacer()
                
                listItem(image: .cardChange, title: "카드 교환권 등록")
            }
            Spacer().frame(height:32)
            
            HStack {
                listItem(image: .coupon, title: "쿠폰 등록")
                Spacer()
                
                listItem(image: .couponHistory, title: "쿠폰 히스토리")
            }
            
            Spacer().frame(height:16)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .background(Color.black.opacity(0.12))
        }
        .padding(.horizontal, 10)
    }
    
    private var supportView: some View {
        VStack (alignment: .leading) {
            Text("고객지원")
                .font(.PretendardSemibold18)
                .foregroundStyle(.black)
            Spacer().frame(height: 8)
            
            HStack {
                listItem(image: .storeCare, title: "스토어 케어")
                Spacer()
                
                listItem(image: .customerSound, title: "고객의 소리")
            }
            
            Spacer().frame(height: 32)
            
            HStack {
                listItem(image: .storeInfo, title: "매장 정보")
                Spacer()
                
                listItem(image: .returnInfo, title: "반납기 정보")
            }
            
            Spacer().frame(height: 32)
            
            HStack {
                listItem(image: .myreview, title: "마이 스타벅스 리뷰")
            }
            
            Spacer().frame(height: 16)
        }
        .padding(.horizontal, 10)
    }
    
    struct listItem: View{
        let image: ImageResource
        let title: String
        var body: some View {
            Button(action:{
                print(title)
            }) {
                HStack(spacing:4){
                    Image(image)
                    Text(title)
                        .font(.PretendardSemibold16)
                        .foregroundStyle(Color.black)
                }
                .frame(width: 157, height:32, alignment: .leading)
            }
        }
    }
}

struct ReceiptView: View {
    var body: some View {
        VStack {
            ReceiptTopBar()

            Spacer()

            ReceiptContentView()

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ReceiptTopBar: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundStyle(.black)
            }

            Spacer()

            Text("전자영수증")
                .font(.PretendardSemibold16)
                .foregroundStyle(.black)

            Spacer()

            Button(action: {
                print("+ 버튼 클릭됨")
            }) {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.black)
            }
        }
        .padding()
        .background(.white)
    }
}


struct ReceiptContentView: View {
    @State private var selectedImage: UIImage?
    @State private var showPicker = false
    @State private var receiptItems: [ReceiptItem] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("총 \(receiptItems.count)건")
                    .foregroundStyle(Color("Highlight"))
                Spacer()
                Text("사용합계 \(totalAmount)원")
                    .foregroundStyle(Color("Highlight"))
            }
            .font(.PretendardRegular24)

            Divider()

            ForEach(receiptItems) { item in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.place)
                            .font(.PretendardBold18)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "dollarsign.square")
                            .foregroundStyle(.green)
                    }

                    Text(item.date)
                        .font(.PretendardRegular14)
                        .foregroundStyle(.gray)

                    Text("\(item.amount)원")
                        .font(.PretendardBold18)
                        .foregroundStyle(Color("Highlight"))
                }

                Divider()
            }
        }
        .padding()
        .background(Color("otherback"))
        .onAppear {
            // 테스트용 기본 데이터
            if receiptItems.isEmpty {
                receiptItems = [
                    ReceiptItem(place: "사당역", date: "2025.01.05 11:30", amount: 6500)
                ]
            }
        }
        .photosPicker(isPresented: $showPicker, selection: .constant(nil), matching: .images)
        .onChange(of: selectedImage) { newImage in
            if let image = newImage {
                performOCR(on: image)
            }
        }
    }

    var totalAmount: Int {
        receiptItems.map { $0.amount }.reduce(0, +)
    }

    func performOCR(on image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

            var newItems: [ReceiptItem] = []

            for observation in observations {
                if let text = observation.topCandidates(1).first?.string {
                    print("🔍 OCR 결과:", text)
                    // 실제 정규식 파싱은 여기에 추가
                }
            }

            DispatchQueue.main.async {
                self.receiptItems = newItems
            }
        }

        request.recognitionLevel = .accurate

        DispatchQueue.global(qos: .userInitiated).async {
            try? requestHandler.perform([request])
        }
    }
}

struct ReceiptItem: Identifiable {
    let id = UUID()
    let place: String
    let date: String
    let amount: Int
}



#Preview {
    OtherView()
}

