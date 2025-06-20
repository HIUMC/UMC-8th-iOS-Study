//
//  AIImageView.swift
//  TestAlamofire
//
//  Created by Apple Coding machine on 5/3/25.
//

import SwiftUI
import Combine

struct AIImageView: View {
    
    @State private var isLoading = false
    @State private var cancellable: AnyCancellable?
    @Binding var image: UIImage?
    
    @State private var progressCancellables = Set<AnyCancellable>() // ✅ 진행률용
    @State private var progress: Double = 0.0
    @State private var progressTimer: Timer?
    
    var body: some View {
        VStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 374, height: 183)
            } else {
                Text("이미지를 생성하려면 버튼을 누르세요")
            }
            
            if isLoading {
                Text("이미지 생성 중... \(Int(progress * 100))%")
                    .foregroundColor(.gray)
            }
            
            Button(isLoading ? "생성 중... \(Int(progress * 100))%" : "이미지 생성") {
                generateImageWithProgress()
            }
            .disabled(isLoading)
            
        }
    }
    
    func generateImageWithProgress() {
        isLoading = true
        progress = 0.0
        
        // 2초마다 진행률 확인 타이머 시작
        progressTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            Txt2ImgService.shared.checkProgress()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in },
                      receiveValue: { response in
                    self.progress = response  // ✅ Double 그대로
                    print("📊 진행률: \(response)")
                })
                .store(in: &progressCancellables)  // ✅ 여기만 바뀜!
            
            let request = Txt2ImgRequest(
                prompt: "a single stylish Starbucks gift card, isolated, no background, transparent background, centered, elegant minimal layout, green and white theme, modern typography, realistic 3D render, sharp edges, floating appearance",
                negativePrompt: "blurry, low quality, distorted, poorly drawn, extra objects, hands, fingers, multiple cards, background clutter, text artifacts, watermark, pixelated, oversaturated, reflections, busy background"
            )
            
            cancellable = Txt2ImgService.shared.generateImage(request: request)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    isLoading = false
                    progressTimer?.invalidate()
                    progress = 0.0
                    progressCancellables.removeAll()

                    if case let .failure(error) = completion {
                        print("❌ 이미지 생성 실패:", error)
                    }
                }, receiveValue: { response in
                    if let base64 = response.images.first,
                       let imageData = Data(base64Encoded: base64),
                       let uiImage = UIImage(data: imageData) {
                        self.image = uiImage
                    } else {
                        print("❌ base64 → 이미지 변환 실패")
                    }
                })
        }
    }
}
