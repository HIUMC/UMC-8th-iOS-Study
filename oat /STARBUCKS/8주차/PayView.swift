//
//  PayView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/27/25.
//

import SwiftUI

struct PayView: View {
    @Environment(\.modelContext) var modelContext
    @State private var generatedImage: UIImage? = nil
    @State private var selectedIndex: Int = 0
    @State private var viewModel = CardViewModel()
    @State private var isShowingAddCardSheet = false
    @State private var cardName = ""
    @State private var cardNumber = ""
    var isValidInput: Bool {
        !cardName.isEmpty && cardNumber.count == 12
    }
    
    var body: some View {
        return NavigationView {
            if viewModel.isLoading {
                ProgressView("카드 불러오는 중...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                VStack {
                    TabView(selection: $selectedIndex) {
                        ForEach(viewModel.cards.indices, id: \.self) { index in
                            if let image = UIImage(data: viewModel.cards[index].imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .tag(index)
                                    .padding(.horizontal, 40)
                                    .frame(height: 200)
                            } else {
                                Color.gray
                                    .tag(index)
                                    .frame(height: 200)
                                    .padding(.horizontal, 40)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 220)
                    
                    if viewModel.cards.indices.contains(selectedIndex) {
                        let card = viewModel.cards[selectedIndex]
                        
                        VStack(spacing: 8) {
                            Text(card.name)
                                .font(.title2)
                                .bold()
                            
                            Text("잔액: \(card.balance)원")
                                .font(.subheadline)
                            
                            Text(maskedCardNumber(card.cardNumber))
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            if viewModel.remainingTime > 0 {
                                Text("유효 시간: \(formattedTime(viewModel.remainingTime))")
                                    .font(.caption2)
                                    .foregroundColor(.green)
                            } else {
                                Text("카드 유효시간이 만료되었습니다.")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.top, 20)
                    }
                    Spacer()
                }
                .onAppear {
                    viewModel.loadCards(context: modelContext)
                    viewModel.startTimer()
                }
                .onChange(of: selectedIndex) {
                    viewModel.startTimer()
                }
                
                .sheet(isPresented: $isShowingAddCardSheet) {
                    addCardSheetView
                }
                .navigationBarItems(trailing: Button(action: {
                    isShowingAddCardSheet = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.black)
                })

            }
        }
    }
        func maskedCardNumber(_ number: String) -> String {
            let suffix = number.suffix(4)
            return "**** **** \(suffix)"
        }
        
        func formattedTime(_ seconds: Int) -> String {
            let minutes = seconds / 60
            let secs = seconds % 60
            return String(format: "%02d:%02d", minutes, secs)
        }
        
        var addCardSheetView: some View {
            NavigationView {
                VStack(spacing: 20) {
                    TextField("카드명 최대 20자", text: $cardName)
                        .onChange(of: cardName) { newValue in
                            if newValue.count > 20 {
                                cardName = String(newValue.prefix(20))                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("카드 번호 12자리", text: $cardNumber)
                        .keyboardType(.numberPad)
                        .onChange(of: cardNumber) { newValue in
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered.count > 12 {
                                cardNumber = String(filtered.prefix(12))
                            } else {
                                cardNumber = filtered
                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    
                    AIImageView(image: $generatedImage)
                        .frame(height: 200)
                    
                    Button("카드 등록하기") {
                        if let image = generatedImage {
                            viewModel.saveCard(
                                name: cardName,
                                cardNumber: cardNumber,
                                image: image,
                                context: modelContext
                            )
                            print("카드 생성 및 저장 완료")
                            cardName = ""
                            cardNumber = ""
                            generatedImage = nil
                            isShowingAddCardSheet = false
                            viewModel.loadCards(context: modelContext)
                        } else {
                            print("이미지가 없음")
                        }
                    }
                    .disabled(!isValidInput || generatedImage == nil)
                    .padding()

                    
                    Spacer()
                }
                .navigationTitle("카드 등록")
                .navigationBarItems(trailing: Button("닫기") {
                    isShowingAddCardSheet = false
                })
            }
        }
}

#Preview {
    PayView()
}

