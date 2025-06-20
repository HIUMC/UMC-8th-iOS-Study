//  AddCardView.swift
//  Starbucks_project

import SwiftUI
import SwiftData

struct AddCardView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Query var allCards: [PayModel]

    @StateObject private var viewModel = AIImageViewModel()

    @State private var name: String = ""
    @State private var cardNumber: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 30) {
            Text("카드 등록")
                .font(.mainTextBold24)
                .padding(.top, 30)

            VStack(alignment: .leading, spacing: 8) {
                Text("카드명 최대 20자")
                    .font(.mainTextMedium16)
                    .foregroundColor(.black01)

                TextField("", text: $name)
                    .padding(.vertical, 6)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 35), alignment: .bottom)
                    .foregroundColor(.black01)
            }
            .padding(.horizontal, 30)

            VStack(alignment: .leading, spacing: 8) {
                Text("카드 번호 12자 입력")
                    .font(.mainTextMedium16)
                    .foregroundColor(.black01)

                TextField("", text: $cardNumber)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 6)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 35), alignment: .bottom)
                    .foregroundColor(.black)
                    .onChange(of: cardNumber) {
                        if cardNumber.count > 12 {
                            cardNumber = String(cardNumber.prefix(12))
                        }
                    }
            }
            .padding(.horizontal, 30)

            VStack(spacing: 10) {
                Button(action: {
                    viewModel.startGenerating(
                        prompt: "a single stylish Starbucks gift card, isolated, no background, transparent background, centered, elegant minimal layout, green and white theme, modern typography, realistic 3D render, sharp edges, floating appearance",
                        negativePrompt: "blurry, low quality, distorted, poorly drawn, extra objects, hands, fingers, multiple cards, background clutter, text artifacts, watermark, pixelated, oversaturated, reflections, busy background"
                    )
                }) {
                    ZStack {
                        Image(viewModel.isLoading ? "addcardbackground" : "pluscard")
                            .resizable()
                            .frame(width: 374, height: 138)
                            .cornerRadius(12)

                        if let base64 = viewModel.generatedImageBase64 {
                            let cleanBase64 = base64.replacingOccurrences(of: "data:image/png;base64,", with: "")
                            if let imageData = Data(base64Encoded: cleanBase64),
                               let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 138)
                                    .cornerRadius(12)
                            }
                        }

                        if viewModel.isLoading || (viewModel.progress > 0 && viewModel.progress < 1.0) {
                            VStack(spacing: 4) {
                                ProgressView(value: viewModel.progress)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .frame(width: 200)

                                Text("\(Int(viewModel.progress * 100))% 생성 중...")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(8)
                        }

                        if viewModel.generatedImageBase64 == nil && !viewModel.isLoading {
                            Image("pluscard")
                                .resizable()
                                .frame(width: 374, height: 138)
                                .cornerRadius(12)
                        }
                    }
                }
                .buttonStyle(.plain)
            }

            Spacer()

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button {
                print("▶️ 등록 버튼 눌림")

                if allCards.contains(where: { $0.cardNumber == cardNumber }) {
                    print("❌ 중복 카드")
                    errorMessage = "이미 존재하는 카드 번호입니다."
                    return
                }

                let money = Int.random(in: 0...19_999_999)
                var imageData: UIImage? = nil

                if let base64 = viewModel.generatedImageBase64 {
                    let cleanBase64 = base64.replacingOccurrences(of: "data:image/png;base64,", with: "")
                    if let data = Data(base64Encoded: cleanBase64),
                       let uiImage = UIImage(data: data) {
                        imageData = uiImage
                    }
                }

                let newCard = PayModel(
                    name: name,
                    balance: money,
                    cardNumber: cardNumber,
                    image: imageData
                )

                context.insert(newCard)
                try? context.save()

                print("✅ 카드 저장됨: \(newCard)")
                dismiss()
            } label: {
                Image("addcard")
                    .resizable()
                    .scaledToFit()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            .disabled(name.isEmpty || cardNumber.count != 12)
        }
    }
}

#Preview {
    AddCardView()
}
