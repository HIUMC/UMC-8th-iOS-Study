//
//  MovieView.swift
//  2nd_Practice
//
//  Created by Yoonseo on 3/22/25.
//

import SwiftUI
import Observation

struct MovieView: View {
    
    @AppStorage("movieName") private var movieName: String = ""
    private var viewModel: MovieViewModel = .init()
    
    
    var body: some View {
        VStack(spacing: 56) {
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            
            leftRightChange
            
            settingMovie
            
            printAppStorageValue
        }
        .padding()
    }
    
    /// 왼쪽 오른쪽 change 버튼
    private var leftRightChange: some View {
        HStack {
            Group {
                makeChevron(name: "chevron.left", action: viewModel.previousMovie)
                
                Spacer()
                
                Text("영화 바꾸기")
                    .font(.system(size: 20, weight: .regular))
                
                Spacer()
                
                makeChevron(name: "chevron.right", action: viewModel.nextMovie)
            }
            .foregroundStyle(Color.black)
        }
        .frame(width: 256)
        .padding(.vertical, 17) /* 이건 뭘 의미하는 걸까요? HStack 내부의 아이템들이 위와 아래에서 충분한 간격을 두고 배치되도록 한다. */
        .padding(.horizontal, 22) /* 이건 뭘 의미하는 걸까요? HStack이 좌우로 충분히 공간을 가지게 하여 화면의 왼쪽과 오른쪽 끝에 너무 붙지 않도록 조정한다. */
    }
    
    /// 화살표 재사용하기 위한 하위 뷰
    /// - Parameters:
    ///   - name: 이미지 이름 설정
    ///   - action: 버튼이 가지는 액션 기능 넣기, @escpaing은 추후 문법을 통해 배우게 될 겁니다! @escaping: 클로저가 함수의 실행이 끝난 후에 호출될 수 있음을 의미합니다. 즉, Button의 action이 makeChevron 함수 내에서 바로 실행되는 것이 아니라, 나중에 버튼이 클릭될 때 실행될 수 있도록 하기 위해서 @escaping을 사용합니다.
    /// 예를 들어, viewModel.previousMovie 또는 viewModel.nextMovie 같은 함수들이 action으로 전달되며, 이 함수들은 버튼이 클릭될 때 실행됩니다. @escaping은 그 함수가 makeChevron 외부에서 실행되도록 보장합니다.
    
    /// - Returns: some View 타입 반환
    private func makeChevron(name: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: name)
                .resizable()
                .frame(width: 17.47, height: 29.73)
        })
    }
    
    /// 대표 영화 설정
    private var settingMovie: some View {
        Button(action: {
            /* 현재 인덱스틔 영화 이름 AppStorage에 저장 */
            self.movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        }, label: {
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(Color.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.leading, 53)
                .padding(.trailing, 52)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .stroke(Color.black, style: .init(lineWidth: 1))
                })
        })
    }
    
    /* 바로 위 코드를 overlay 안 쓰고 ZStack 이용한 것
    ZStack {
    RoundedRectangle(cornerRadius: 20)
        .fill(Color.clear) // 내부를 투명하게
        .stroke(Color.black, lineWidth: 1) // 테두리 추가

    Text("대표 영화로 설정")
        .font(.system(size: 20, weight: .regular))
        .foregroundColor(.black)
        .padding()
}
.frame(width: 200, height: 50) // ZStack 크기 설정
*/
    
    /*
     ZStack 은 여러 요소를 쉽게 겹칠수있고 구조가 직관적이지만 .frame()을 수동으로 지정해야 할수도 잇음
     overlay 는 기존 요소 위에 추가할 때 간편하지만 복잡한 배치에는 다소 불편함
     */
    
    /// 하단 AppStorage에 저장된 영화 확인 텍스트
    private var printAppStorageValue: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
                .font(.system(size: 30, weight: .regular))
                .foregroundStyle(Color.black)
            
            Text("현재 저장된 영화 : \(movieName)")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(Color.red)
        }
    }
}

#Preview {
    MovieView()
}
