
//
//  SighupViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/30/25.
//

import Foundation
import SwiftUI
import Observation


class SignupViewModel: ObservedObject { //매크로 쓰면 AppStorage 이게 안되는 것 같음 그니가 View에서 구현해야하니까 . 딴 사람들 다 이거 아 ㄴ썻서
    
    @StateObject var nickname: String = ""
    @StateObject var email: String = ""
    @StateObject var password: String = ""
    
    /*init(viewModel: SignupViewModel = SignupViewModel()) {
     self._viewModel = Bindable(wrappedValue: viewModel)
 }
    */
    
    @AppStorage("nickname") private var savedNickname=""
    @AppStorage("email") private var savedEmail=""
    @AppStorage("password") private var savedPassword=""
    
    // 모델 객체 생성 함수 (저장은 하지 않음)
    func saveUser() -> SignupModel {
        return SignupModel(nickname: nickname, email: email, password: password)
    }
    
    //이건 단순히 입력된 데이터를 SignupModel로 감싼 객체를 반환만 하는 함수야.
    //즉, “저장되는 건 아니고” !! 그냥 데이터를 하나의 객체로 묶어서 반환
    
    
    
    /*//Appstorage 저장소
     @AppStorage("nickname") private var savedNickname=""
     @AppStorage("email") private var savedEmail=""
     @AppStorage("password") private var savedPassword=""
     -> SignupView로 옮겨야대
     //실습 코드(참고용)
     @Observable
     class MovieViewModel{
     
     var currentIndex: Int = 0
     
     let movieModel:[MovieModel]=[
     .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8),
     .init(movieImage: .init(.toyStory), movieName: "토이스토리", movieLike: 999, movieReserCount: 99.8),
     .init(movieImage: .init(.brutalis), movieName: "브루탈리스트", movieLike: 302, movieReserCount: 24.8),
     .init(movieImage: .init(.snowWhite), movieName: "백설공주", movieLike: 302, movieReserCount: 3.8),
     .init(movieImage: .init(.whiplash), movieName: "위플래시", movieLike: 604, movieReserCount: 62.8),
     .init(movieImage: .init(.conclave), movieName: "콘클라베", movieLike: 392, movieReserCount: 43.9),
     .init(movieImage: .init(.theFall), movieName: "더폴", movieLike: 30, movieReserCount: 2.1)
     ]
     
     ///이전 영화로 돌아가기. 단, 첫번째 영화일 경우 마지막 영화로 전환
     public func previousMovie(){
     currentIndex=(currentIndex-1+movieModel.count)%movieModel.count
     }
     
     ///오른쪽 버튼 눌렀을 때 다음 영화로 이동하는 함수
     public func nextMovie(){
     currentIndex=(currentIndex+1)%movieModel.count
     }
     }
     */
    
    //생성 버튼 액션: AppStorage에 저장
    /*func saveUser() {
     let user = SignupModel(nickname: nickname, email: email, password: password)
     savedNickname = user.nickname
     savedEmail = user.email
     savedPassword = user.password
     }*/
    
    
}
