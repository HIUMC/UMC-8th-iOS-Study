//
//  CardRegisterView.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/19/25.
//
import SwiftUI
import Combine

struct CardRegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CardRegisterViewModel()
    @State private var cancellable = Set<AnyCancellable>()
    
    // 입력 상태
    @State private var name: String = ""
    @State private var cardNumber: String = ""
    @State private var image: UIImage? = nil
    @State private var isGenerating: Bool = false
    @State private var progress: Double = 0.0
    
    // 등록 불가 조건
    var canRegister: Bool {
        !name.isEmpty && cardNumber.count == 12 && image != nil
    }

    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                
                Capsule()
                               .fill(Color(.systemGray4))
                               .frame(width: 48, height: 6)
                               .padding(.top, 10)
                               //.padding(.bottom, 8)
                // 타이틀
                Text("카드 등록")
                    .font(.mainTextBold24)
                    //.padding(.top)
            
                VStack(alignment: .leading, spacing: 8) {
                    /*Text("카드명 최대 20자")
                        .font(.mainTextBold16)
                        .foregroundColor(Color("black01"))
                     */
                    TextField("카드명 최대 ㅎ12자", text: $name)
                        .font(.mainTextMedium16)
                        .foregroundColor(Color("black03"))
                        .textFieldStyle(.plain)
                                .padding(.vertical, 10)    // 위아래 공간 확보
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(.systemGray3)),
                                    alignment: .bottom)
                        .onChange(of: name) { newValue in
                            if newValue.count > 20 {
                                name = String(newValue.prefix(20))
                            }
                        }
                    
                    /*Text("카드 번호 12자 입력")
                        .font(.mainTextMedium16)
                        .foregroundColor(Color("black01"))
                     */
                    TextField("카드 번호 12자 입력", text: $cardNumber)
                        .keyboardType(.numberPad)
                        .font(.mainTextMedium16)
                        .foregroundColor(Color("black03"))
                        .textFieldStyle(.plain)
                                .padding(.vertical, 10)    // 위아래 공간 확보
                                .overlay(
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(.systemGray3)),
                                    alignment: .bottom)
                        .onChange(of: cardNumber) { newValue in
                            let filtered = newValue.filter { $0.isNumber }
                            cardNumber = String(filtered.prefix(12))
                        }
                }
                .padding(.horizontal)
                
                // 카드 이미지 생성 버튼/진행/완료
                Group {
                    if image == nil && !isGenerating {
                        Button(action: {
                            
                                viewModel.generateImage(prompt: "a single stylish Starbucks gift card, isolated, no background, transparent background, centered, elegant minimal layout, green and white theme, modern typography, realistic 3D render, sharp edges, floating appearance",negativePrompt: "blurry, low quality, distorted, poorly drawn, extra objects, hands, fingers, multiple cards, background clutter, text artifacts, watermark, pixelated, oversaturated, reflections, busy background")
                            
                        }) {
                            VStack {
                                Image(systemName: "plus")
                                    .frame(width: 36, height: 36)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color("gray05"))
                                Text("카드 이미지 생성하기")
                                    .font(.mainTextMedium16)
                                    .foregroundColor(Color("gray05"))
                            }
                            .frame(width: 360, height: 183)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    } else if isGenerating {
                        VStack(spacing: 16) {
                            HStack {
                                ProgressView()
                                Text("이미지 생성 중…")
                                    .font(.mainTextMedium16)
                                    .foregroundColor(Color("gray05"))
                            }
                            Text("\(Int((viewModel.progress * 100).rounded()))% 완료")
                                .font(.mainTextMedium16)
                                .foregroundColor(Color("gray05"))
                                .alignment(.center)
                        }
                        .frame(width: 360, height: 183)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    } else if let img = image {
                        Image(uiImage: img)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 360, height: 183)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            
                // 등록 버튼
                Button(action: {
                    guard canRegister else { return }
                    let price = Int.random(in: 0...1_999_999)
                    let card = Card( imageName: "starbucks", name: name, price: price, cardNumber: cardNumber, initialSeconds: 60, remainingSeconds: 60)
                        //.onRegister(card)
                    dismiss()
                }) {
                    Text("카드 등록하기")
                        .foregroundColor(Color("white01"))
                        .frame(width: 360, height: 35 )
                        .padding()
                        .background(Color("green01"))
                        .cornerRadius(16)
                }
                .disabled(!canRegister)
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationBarHidden(true)
        }
    }
    
    // 이미지 생성 시뮬레이션
    func generateCardImage() {
        isGenerating = true
        progress = 0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress < 1.0 {
                progress += 0.03
            } else {
                timer.invalidate()
                isGenerating = false
                // 실제론 AI 이미지 API에서 받아온 이미지로 대체!
                image = UIImage(named: "starbucks") ?? UIImage()
            }
        }
    }
}

