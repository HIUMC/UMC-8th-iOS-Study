import SwiftUI
import SwiftData

struct StarbucksCardCreatingView: View {
    
    // MARK: - 변수
    @Environment(\.modelContext) private var context
    @Query private var cards: [StarbucksCardModel]
    @Binding var isPresented: Bool
    
    @State private var cardName: String
    @State private var cardNumber: String
    @FocusState private var focusField: Field?
    @State private var showDuplicateAlert = false
    
    enum Field: Hashable {
        case cardName, cardNumber
    }

    init(isPresented: Binding<Bool>, cardName: String = "", cardNumber: String = "") {
        _isPresented = isPresented
        _cardName = State(initialValue: cardName)
        _cardNumber = State(initialValue: cardNumber)
    }

    // MARK: - 메인 뷰
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 10)
            
            Text("카드 등록")
                .font(.headline)
                .padding(.vertical, 16)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 48)

            CardNameTextFieldView(cardName: $cardName, focusField: $focusField)
            
            Spacer().frame(height: 45)
            
            CardNumberTextFieldView(cardNumber: $cardNumber, focusField: $focusField)

            Spacer().frame(height: 25)

            CardImageButton {
                // 이미지 생성 로직
            }

            Spacer()

            RegisterCardButton {
                // 카드 등록 로직
                saveCard()
            }
            
            Spacer().frame(height: 20)
        }
        .padding(.horizontal, 32)
        .alert("이미 등록된 카드번호입니다.", isPresented: $showDuplicateAlert) {
            Button("확인", role: .cancel) {}
        }
    }
    
    // MARK: - 카드 등록하기 함수
    private func saveCard() {
        
        if cardName.isEmpty {
            focusField = .cardName
        } else if cardNumber.isEmpty || cardNumber.count != 12 {
            focusField = .cardNumber
        } else {
            if let cardNumberInt = Int(cardNumber) {
                
                // 같은 카드번호가 이미 존재할 경우 Alert 띄운다.
                if cards.contains(where: { $0.cardNumber == cardNumberInt }) {
                    showDuplicateAlert = true
                    return
                            }
                
                let card = StarbucksCardModel(cardName: cardName, cardNumber: cardNumberInt)
                
                // SiwftData 저장 처리
                context.insert(card)
                try? context.save()
                cardName = ""
                cardNumber = ""
                
                // sheet 자동 닫힘 처리
                isPresented = false
            } else {
                // 숫자 변환 실패: 숫자 아닌 문자가 포함됨
                focusField = .cardNumber
            }
        }
    }
    
}

#Preview {
    StarbucksCardCreatingView(isPresented: .constant(true))
}

// MARK: - 1-1. 카드명 입력 필드
struct CardNameTextFieldView: View {
    @Binding var cardName: String
    @FocusState.Binding var focusField: StarbucksCardCreatingView.Field?

    var body: some View {
        CustomTextField(placeholder: "카드명 최대 20자", text: $cardName)
            .onChange(of: cardName) {
                if cardName.count > 20 {
                    cardName = String(cardName.prefix(20))
                }
            }
            .focused($focusField, equals: .cardName)
    }
}

// MARK: - 1-2. 카드번호 입력 필드
struct CardNumberTextFieldView: View {
    @Binding var cardNumber: String
    @FocusState.Binding var focusField: StarbucksCardCreatingView.Field?

    var body: some View {
        CustomTextField(placeholder: "카드 번호 12자 입력", text: $cardNumber)
            .onChange(of: cardNumber) {
                let filtered = cardNumber.filter { $0.isNumber }
                if filtered.count > 12 {
                    cardNumber = String(filtered.prefix(12))
                } else {
                    cardNumber = filtered
                }
            }
            .keyboardType(.numberPad)
            .focused($focusField, equals: .cardNumber)
    }
}


// MARK: - 2. 카드 이미지 버튼
struct CardImageButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
                    .frame(maxWidth: .infinity, minHeight: 183, maxHeight: 183)


                VStack {
                    Image(systemName: "plus")
                        .foregroundStyle(.customBlack)
                        .font(.system(size: 36, weight: .bold))

                    Spacer().frame(height: 15)

                    Text("카드 이미지 생성하기")
                        .font(.customPretend(.regular, size: 16))
                        .foregroundStyle(.customBlack)
                }
            }
        }
    }
}

// MARK: - 3. 카드 등록하기 버튼
struct RegisterCardButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 100, style: .continuous)
                    .fill(.mainGreen)
                    .frame(height: 40)

                Text("카드 등록하기")
                    .foregroundStyle(.white)
            }
        }
    }
}
