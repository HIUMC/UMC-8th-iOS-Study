//
//  ReceiptsView.swift
//  Practice4
//
//  Created by 신민정 on 4/3/25.
//
import SwiftUI
import Observation

struct ReceiptsView: View {
    
    @Bindable var viewModel: ReceiptsViewModel = .init()
    
    var body: some View {
        VStack(spacing: 42) {
            HStack {
                ForEach(ReceiptSegment.allCases, id: \.id) { segment in
                    topSegment(segment: segment)
                }
            }
            
            tabView
        }
        .frame(maxWidth: 337, maxHeight: .infinity)
    }
    
    //상단 세그먼트
    //세그먼트: 여러개중 하나의 선택지
    //그걸 클릭하면 선택한걸 보여주는 줄이 생김
    //세그먼트를 클릭했을 때 세그먼트 텍스트 아래의 표시 막대가 보여야함
    @ViewBuilder
    func topSegment(segment: ReceiptSegment) -> some View {
        VStack(spacing: 0) {
            Text(segment.title)
                .foregroundStyle(Color.black)
                .font(.system(size: 40))
                .onTapGesture {
                    viewModel.selectedSegment = segment
                }
            if viewModel.selectedSegment == segment {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 116, height: 2) //줄표시
            }
        }
        .frame(maxWidth: .infinity)
        
        if segment == .first {
            Spacer()
        }
    }
    //택뷰를 쓰는이유
    // 탭뷰는 .page와 함께 사용할 때 1. 좌우 스와이프 동작이 자동으로 포함 -> 사용자는 직관적으로 손가락으로 넘겨서 탭 간 전환이 가능함
    //2. 탭뷰(selction:) 을 사용하면 현재 탭 인덱스 혹은 enum을 바인딩 해놓고 탭에 맞는 뷰를 자동으로 불러옴 -> 탭뷰 셀렉션을 하면 여러개를 고를 수 있는 목록을(enum)을 연결(바인딩)한다, "지금 어떤 걸 고르고 있는지 상태 연결합니당" @State 이걸로! 탭에 맞는 뷰를 자동으로 불러와진다: 내가 홈탭을 누르면 홈화면이, 서치 탭을 누르면 서치 화면이 나옴
    
    private var tabView: some View {
            TabView(selection: $viewModel.selectedSegment, content: {
                ForEach(ReceiptSegment.allCases, id: \.id) { segment in
                    VStack(spacing: 10) {
                        Image(segment.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 490)
                        
                        if viewModel.selectedSegment == segment {
                                                if let receipt = viewModel.currentReceipt {
                                                    ReceiptInfoView(receipt: receipt)
                                                } else {
                                                    ProgressView("OCR 처리 중...")
                                                }
                        }
                    }
                    .tag(segment)
                    /* 세그먼트의 탭 화면이 등장할 때 OCR 추출이 돼야 하기 때문에 task로 작성합니다. */
                    .task {
                        viewModel.startOCR(segment)
                    }
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }

    #Preview {
        ReceiptsView()
    }

