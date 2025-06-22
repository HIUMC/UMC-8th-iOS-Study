//
//  AIImageViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 6/19/25.
//


import Foundation
import Combine
import Moya

class AIImageViewModel: ObservableObject {
    @Published var generatedImageBase64: String? = nil
    @Published var isLoading: Bool = false
    @Published var progress: Double = 0.0

    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?

    private let provider: MoyaProvider<AIImageTarget> = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300 // 요청 타임아웃 (초)
        configuration.timeoutIntervalForResource = 300

        let session = Session(configuration: configuration)

        return MoyaProvider<AIImageTarget>(
            session: session,
            plugins: [NetworkLoggerPlugin()]
        )
    }()

    

    func startGenerating(prompt: String, negativePrompt: String) {
        isLoading = true
        progress = 0.0
        generatedImageBase64 = nil

        // 1. 이미지 생성 요청
        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)
        provider.requestPublisher(.generateImage(request: request))
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    print("❌ 이미지 생성 요청 실패:", error)
                    self?.isLoading = false
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }

                if let jsonString = try? response.mapString() {
                    print("📦 [generateImage] 응답:\n\(jsonString)")
                }

                if let data = try? response.map(Txt2ImgImageOnlyResponse.self),
                   let base64 = data.images.first {
                    print("🖼 base64 수신 성공")
                    self.generatedImageBase64 = base64
                    
                    // ✅ 이미지 도착했으면 강제로 100%로 설정
                    self.progress = 1.0
                    self.isLoading = false
                    self.stopProgressPolling()
                } else {
                    print("⚠️ 이미지 응답 파싱 실패")
                }
            }
)
            .store(in: &cancellables)

        // 2. 프로그레스 폴링 시작
        startProgressPolling()
    }

    private func startProgressPolling() {
        timer?.cancel()
        timer = Timer.publish(every: 2.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchProgress()
            }
    }

    private func stopProgressPolling() {
        timer?.cancel()
        timer = nil
    }

    private func fetchProgress() {
        provider.requestPublisher(.checkProgress)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                guard let self = self,
                      let progressData = try? response.map(ProgressResponse.self) else { return }
                DispatchQueue.main.async {
                    self.progress = progressData.progress
                    
                    if progressData.progress >= 1.0 {
                        print("✅ 생성 완료, 로딩 종료")
                            self.progress = 1.0
                        self.isLoading = false
                        self.stopProgressPolling()
                    }
                }
            })
            .store(in: &cancellables)
    }

}

struct ProgressResponse: Decodable {
    let progress: Double
}
