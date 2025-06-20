import SwiftUI
import SwiftData
import Combine

//MARK: -모델
@Model
class CardModel {
    var imageName: String
    var cardName: String
    var balance: String
    var cardNumber: String
    var expireTime: Int

    init(imageName: String, cardName: String, balance: String, cardNumber: String, expireTime: Int) {
        self.imageName = imageName
        self.cardName = cardName
        self.balance = balance
        self.cardNumber = cardNumber
        self.expireTime = expireTime
    }
}
//MARK: -뷰모델
class PayViewModel: ObservableObject {
    @Published var cards: [CardModel]
    @Published var selectedIndex: Int = 0
    @Published var timeLeft: Int = 180 // seconds
    private var cancellable: AnyCancellable?

    init(cards: [CardModel]) {
        self.cards = cards
        // Removed timer start here to avoid index out-of-bounds when cards is empty
    }
//MARK: -시간 함수(비동기 처리)
    func startTimer(duration: Int) {
        timeLeft = duration
        cancellable?.cancel()
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                } else {
                    self.cancellable?.cancel()
                }
            }
    }

    func timeString() -> String {
        let minutes = timeLeft / 60
        let seconds = timeLeft % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//MARK: -뷰
struct PayView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \CardModel.cardName, order: .reverse) private var storedCards: [CardModel]
    @StateObject var viewModel = PayViewModel(cards: [])

    @State private var showSheet = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Pay")
                        .font(.PretendardBold24)
                        
                    Spacer()
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName:"plus")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.black)
                            
                    })
                }
                .padding(.horizontal)
                Spacer().frame(height:30) // 상단 여백
                CardCarouselView(selectedIndex: $viewModel.selectedIndex, cards: viewModel.cards, timeLeftText: viewModel.timeString())
                Spacer()
            }
        }
        .onAppear {
            if storedCards.isEmpty {
                let defaultCards = [
                    CardModel(imageName: "card1", cardName: "기본카드 A", balance: "₩1,000", cardNumber: "123456789012", expireTime: 180),
                    CardModel(imageName: "card1", cardName: "기본카드 B", balance: "₩2,000", cardNumber: "234567890123", expireTime: 180),
                    CardModel(imageName: "card1", cardName: "기본카드 C", balance: "₩3,000", cardNumber: "345678901234", expireTime: 180)
                ]
                for card in defaultCards {
                    context.insert(card)
                }
                try? context.save()
            }
            viewModel.cards = storedCards
            if let first = storedCards.first {
                viewModel.startTimer(duration: first.expireTime)
            }
        }
        .onChange(of: viewModel.selectedIndex) { newIndex in
            let duration = viewModel.cards[newIndex].expireTime
            viewModel.startTimer(duration: duration)
        }
        .onChange(of: storedCards) { newValue in
            viewModel.cards = newValue
            if let first = newValue.first {
                viewModel.startTimer(duration: first.expireTime)
            }
        }
        .sheet(isPresented: $showSheet) {
            RegisterCardSheetView()
        }
    }
}

//MARK: -CarouselView (하위뷰)
struct CardCarouselView: View {
    @Binding var selectedIndex: Int
    var cards: [CardModel]
    var timeLeftText: String

    var body: some View {
        VStack(spacing: 16) {
            TabView(selection: $selectedIndex) {
                ForEach(cards.indices, id: \.self) { index in
                    Image(cards[index].imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 272, height: 143)
                        .clipped()
                }
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            VStack(spacing: 6) {
                if cards.indices.contains(selectedIndex) {
                    Text(cards[selectedIndex].cardName)
                        .font(.PretendardMedium14)
                        .foregroundStyle(.gray06)
                    Text(cards[selectedIndex].balance)
                        .font(.PretendardSemiBold18)
                    Text(maskedNumber(cards[selectedIndex].cardNumber))
                        .font(.PretendardRegular12)

                    if timeLeftText != "00:00" {
                        HStack(spacing: 0) {
                            Text("카드 유효 시간 ")
                                .font(.PretendardRegular12)
                                .foregroundColor(.gray)
                            Text(timeLeftText)
                                .font(.PretendardRegular12)
                                .foregroundColor(.green)
                        }
                    } else {
                        Text("카드 유효시간이 만료되었습니다")
                            .font(.PretendardRegular12)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }

    //MARK: -카드번호 앞 8자리 가리는 함수
    func maskedNumber(_ number: String) -> String {
        let last4 = number.suffix(4)
        return "****-****-\(last4)"
    }
}

//MARK: -카드 추가 Sheet
struct RegisterCardSheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var cardName: String = ""
    @State private var cardNumber: String = ""

    var isFormValid: Bool {
        !cardName.isEmpty && cardNumber.count == 12
    }

    var body: some View {
        VStack(spacing: 20) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 10)

            Text("카드 등록")
              .font(
                Font.custom("Pretendard", size: 24)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))

            VStack(alignment: .leading, spacing: 4) {
                TextField("카드명 최대 20자", text: $cardName)
                    .font(.PretendardMedium16)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .onChange(of: cardName) { newValue in
                if newValue.count > 20 {
                    cardName = String(newValue.prefix(20))
                }
            }

            //키패드안뜸..
            VStack(alignment: .leading, spacing: 4) {
                TextField("카드 번호 12자 입력", text: $cardNumber)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .onChange(of: cardNumber) { newValue in
                        // 숫자만 허용하고 최대 12자리까지 제한
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count > 12 {
                            cardNumber = String(filtered.prefix(12))
                        } else {
                            cardNumber = filtered
                        }
                    }
                    .font(.PretendardMedium16)
                    .frame(height: 40)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)

            
//            .padding(.horizontal, 123)
//            .padding(.vertical, 56)
//            .frame(width: 374, height: 183, alignment: .topLeading)
//            .background(Color(red: 0.97, green: 0.97, blue: 0.97))
//            .cornerRadius(10)
 
            
            Spacer()
            
            Button(action: {
                let randomBalance = Int.random(in: 0...10000)
                let formattedBalance = NumberFormatter.localizedString(from: NSNumber(value: randomBalance), number: .decimal)
                let newCard = CardModel(
                    imageName: "card1",
                    cardName: cardName,
                    balance: "₩\(formattedBalance)",
                    cardNumber: cardNumber,
                    expireTime: 180
                )
                context.insert(newCard)
                try? context.save()
                dismiss()
            }, label: {
                Text("카드 등록하기")
                    .font(.PretendardMedium16)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.green : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(30)
                    .padding(.horizontal)
            })
            .disabled(!isFormValid)
        }
        .presentationDetents([.large])
    }
}

#Preview {
    let config = ModelConfiguration(for: CardModel.self)
    let container = try! ModelContainer(for: CardModel.self, configurations: config)
    return PayView()
        .modelContainer(container)
}
