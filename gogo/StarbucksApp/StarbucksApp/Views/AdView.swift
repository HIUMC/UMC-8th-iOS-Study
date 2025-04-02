////
////
////
//
//
//
////
//
//import SwiftUI
//
//struct AdView: View{
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        VStack {
//            Image("ad")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea(edges: .top)
//                .frame(maxWidth: .infinity, maxHeight: 720)
//            
//            Spacer().frame(height: 106)
//            
//            Button(action:{
//                print("자세히 보기")
//            }, label: {
//                Text("자세히 보기")
//                    .font(.PretendardMedium18)
//                    .foregroundStyle(Color.white
//                    )
//                    .frame(maxWidth: 402, maxHeight: 58)
//                    
//                    
//                    .background(Color.green01)
//                    .cornerRadius(20)
//                    .padding(.horizontal, 18)
//            })
//            
//            Spacer().frame(height: 19)
//            
//            HStack {
//                Spacer()
//                Button(action: {
//                    print("닫기 버튼 클릭")
//                    dismiss()
//                }, label: {
//                    Text("X 닫기")
//                        .font(.PretendardRegular13)
//                        .foregroundStyle(Color.gray01)
//                        .padding(.trailing, 37)
//                })
//            }
//            
//            Spacer().frame(height: 36)
//        }
//    }
//}
//#Preview {
//    AdView()
//}
