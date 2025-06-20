import Foundation
import Combine

@MainActor
final class CountdownTimer: ObservableObject {
    @Published private(set) var secondsLeft: Int = 180
    private var ticker: AnyCancellable?

    func start() {
        stop()
        ticker = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                if secondsLeft > 0 { secondsLeft -= 1 }
            }
    }

    func reset() { secondsLeft = 180 }
    func stop() { ticker?.cancel(); ticker = nil }
}
