import SwiftUI

struct DetailView: View {
    let coffee: DetailModel
    @State private var selectedOption: Option = .iced
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            VStack {
                ZStack(alignment: .top) {
                    Image(coffee.detailImageName)
                        .frame(maxWidth: .infinity)
                        .frame(height: 195)

                    Group {
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(.back)
                            }
                            Spacer()
                            Image(.shar)
                        }
                    }
                    .ignoresSafeArea()
                    .padding()
                }

                Spacer().frame(height: 90)

                VStack(alignment: .leading) {
                    Spacer().frame(height: 20)

                    HStack(spacing: 4) {
                        Text(coffee.nameKR)
                            .font(.mainTextSemibold24)
                            .foregroundStyle(Color.black03)
                        Image(.new)
                    }

                    Text(coffee.nameEN)
                        .font(.mainTextSemiBold14)
                        .foregroundStyle(Color.gray01)

                    Spacer().frame(height: 32)

                    Text(coffee.description)
                        .font(.mainTextSemiBold14)
                        .foregroundStyle(Color.gray06)

                    Spacer().frame(height: 20)

                    Text("\(coffee.price)원")
                        .font(.mainTextBold24)
                        .foregroundStyle(Color(red: 0.07, green: 0.07, blue: 0.07))

                    if coffee.options.contains(.hot) && coffee.options.contains(.iced) {
                        segmentedControl
                    } else if coffee.options.contains(.iced) {
                        Text("ICED ONLY")
                            .font(.mainTextBold15)
                            .foregroundStyle(Color.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color.gray00)
                            )
                        Spacer()
                    } else if coffee.options.contains(.hot) {
                        Text("HOT ONLY")
                            .font(.mainTextBold15)
                            .foregroundStyle(Color.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 36)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray00)
                            )
                        Spacer()
                    } else {
                        EmptyView()
                    }

                    ZStack {
                        Rectangle()
                            .foregroundStyle(Color.white)
                            .frame(height: 73)
                            .overlay(
                                Rectangle()
                                    .fill(Color.gray07)
                                    .frame(height: 1)
                                    .blur(radius: 2),
                                alignment: .top
                            )

                        Button(action: {
                            print("버튼 눌림")
                        }) {
                            RoundedRectangle(cornerRadius: 999)
                                .fill(Color.green00)
                                .frame(maxWidth: .infinity)
                                .frame(height: 43)
                                .overlay(
                                    Text("주문하기")
                                        .font(.makeMedium18)
                                        .foregroundStyle(Color.white)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }

    var segmentedControl: some View {
        GeometryReader { geometry in
            ZStack(alignment: selectedOption == .iced ? .leading : .trailing) {
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.gray07)
                    .frame(height: 36)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray00)
                    )

                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.white)
                    .frame(width: geometry.size.width / 2)
                    .frame(height: 36)
                    .animation(.easeInOut, value: selectedOption)

                HStack(spacing: 0) {
                    Text("ICED")
                        .font(.mainTextSemiBold18)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .foregroundStyle(selectedOption == .iced ? .blue : .gray)
                        .onTapGesture {
                            withAnimation {
                                selectedOption = .iced
                            }
                        }

                    Text("HOT")
                        .font(.mainTextSemiBold18)
                        .frame(maxWidth: .infinity)
                        .frame(height: 36)
                        .foregroundStyle(selectedOption == .hot ? .red : .gray)
                        .onTapGesture {
                            withAnimation {
                                selectedOption = .hot
                            }
                        }
                }
            }
        }
    }
}
