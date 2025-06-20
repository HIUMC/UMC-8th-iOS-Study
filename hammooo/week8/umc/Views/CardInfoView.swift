import SwiftUI

struct CardInfoView: View {
    let card: Card
    let secondsLeft: Int

    var timeString: String {
        let m = secondsLeft / 60
        let s = secondsLeft % 60
        return String(format: "%02d:%02d", m, s)
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(card.name)
                .font(.subheadline.weight(.medium))
                .padding(.top, 8)

            Text("\(card.price)원")
                .font(.title3.bold())

            Text(card.number.maskedCardNumber)
                .font(.callout.monospacedDigit())

            Group {
                if secondsLeft == 0 {
                    Text("카드 유효시간이 만료되었습니다.")
                } else {
                    Text("카드 유효 시간 \(timeString)")
                        .foregroundStyle(.green)
                }
            }
            .font(.footnote)
        }
        .animation(.easeInOut, value: secondsLeft)
    }
}
