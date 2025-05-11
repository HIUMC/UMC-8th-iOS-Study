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
                switch value {
                case "receipt":
                    ReceiptView()
                case "storemap":
                    MapView()
                default:
                    EmptyView()
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
                listItem(image: .storeInfo, title: "매장 정보") {
                    path.append("storemap")
                }

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
    
    struct listItem: View {
        let image: ImageResource
        let title: String
        var action: () -> Void = {
            print("Default action")
        }

        var body: some View {
            Button(action: action) {
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
    @State private var showPicker = false
    @State private var selectedImage: UIImage?
    @State private var receiptItems: [ReceiptItem] = []
    @State private var previewImage: IdentifiableImage?

    var body: some View {
        VStack {
            ReceiptTopBar(showPicker: $showPicker)

            Spacer()

            ReceiptContentView(
                showPicker: $showPicker,
                selectedImage: $selectedImage,
                receiptItems: $receiptItems,
                previewImage: $previewImage
            )

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(item: $previewImage) { identifiable in
            ReceiptImagePreview(image: identifiable.image) {
                previewImage = nil
            }
        }
    }
}

struct ReceiptTopBar: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showPicker: Bool
    @State private var showDialog = false

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

            Button {
                showDialog = true
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.black)
            }
            .confirmationDialog("이미지 가져오기", isPresented: $showDialog, titleVisibility: .visible) {
                Button("앨범에서 가져오기") {
                    showPicker = true
                }

                Button("카메라로 촬영하기") {
                    // 추후 구현
                    print("카메라 실행")
                }

                Button("취소", role: .cancel) {}
            }
        }
        .padding()
        .background(.white)
    }
}


struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: UIImage
}


struct ReceiptContentView: View {
    @Binding var showPicker: Bool
    @Binding var selectedImage: UIImage?
    @Binding var receiptItems: [ReceiptItem]
    @Binding var previewImage: IdentifiableImage?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView

            Divider()

            receiptList

            Spacer()
        }
        .padding()
        .background(Color("otherback"))
        .photosPicker(isPresented: $showPicker, selection: .constant(nil), matching: .images)
        .onChange(of: selectedImage) { newImage in
            if let image = newImage {
                performOCR(on: image)
            }
        }
    }

    private var headerView: some View {
        let totalText = "총 \(receiptItems.count)건"
        let amountText = "사용합계 \(receiptItems.map(\.amount).reduce(0, +))원"

        return HStack {
            Text(totalText)
                .foregroundStyle(Color("Highlight"))
            Spacer()
            Text(amountText)
                .foregroundStyle(Color("Highlight"))
        }
        .font(.PretendardRegular24)
    }

    private var receiptList: some View {
        ForEach(receiptItems) { item in
            Button {
                if let image = selectedImage {
                    previewImage = IdentifiableImage(image: image)
                }
            } label: {
                ReceiptRow(item: item)
            }
        }
    }

    private func performOCR(on image: UIImage) {
        guard let cgImage = image.cgImage else { return }

        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

            var place: String?
            var date: String?
            var amount: Int?

            for observation in observations {
                if let text = observation.topCandidates(1).first?.string {
                    print("🔍 OCR:", text)

                    if date == nil,
                       let match = text.range(of: #"(\d{2,4})\.\d{2}\.\d{2}"#, options: .regularExpression) {
                        date = String(text[match])
                    }

                    if amount == nil,
                       let match = text.range(of: #"(\d{1,3}(,\d{3})*|\d+)(?= ?원|₩)"#, options: .regularExpression) {
                        let clean = text[match].replacingOccurrences(of: ",", with: "")
                        amount = Int(clean)
                    }

                    if place == nil,
                       text.range(of: #"^[가-힣A-Za-z\s]+$"#, options: .regularExpression) != nil,
                       text.count > 2 {
                        place = text.trimmingCharacters(in: .whitespaces)
                    }
                }
            }

            if let place = place, let date = date, let amount = amount {
                let newItem = ReceiptItem(place: place, date: date, amount: amount)
                DispatchQueue.main.async {
                    receiptItems.append(newItem)
                }
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

struct ReceiptRow: View {
    let item: ReceiptItem

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(item.place)
                    .font(.PretendardBold16)
                    .foregroundStyle(.black)
                Spacer()
                Image(systemName: "dollarsign.square")
                    .foregroundStyle(.green)
            }

            Text(item.date)
                .font(.PretendardRegular13)
                .foregroundStyle(.gray)

            Text("\(item.amount)원")
                .font(.PretendardBold16)
                .foregroundStyle(Color("Highlight"))

            Divider()
        }
    }
}

struct ReceiptImagePreview: View {
    let image: UIImage
    let dismiss: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()

            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .padding()

            Button(action: dismiss) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}





#Preview {
    OtherView()
}

