//
//  OrderView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var viewModel: JSONParsingViewModel
    @State private var selectedTab: OrderSegment = .allMenu
    @Namespace private var menuLowBar
    @State var showSheet: Bool = false
    
    var body: some View {
        (VStack {
            navigationBar
            if selectedTab == .allMenu {
                AllMenuView()
                    .padding(.bottom, -7)
            } else {
                Spacer()
            }
            storeSheetButton
        })
        .ignoresSafeArea(edges: .top)
    }
    
    
    private var navigationBar: some View {
        ZStack(alignment: .top) {
            Color.white
                .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 3)
            VStack {
                Spacer()
                HStack {
                    Text("Order")
                        .font(.MainTextBold24)
                        .foregroundStyle(.black)
                        .padding(.leading, 23.5)
                        .padding(.bottom, 16)
                    Spacer()
                }
                menuBar
                    .offset(y:5)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 155)
            
    }
    
    private var menuBar: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(OrderSegment.allCases, id: \.self) { tab in
                    Button(action: {
                        withAnimation(.bouncy) {
                            selectedTab = tab
                        }
                        
                    },
                    label: {
                        VStack {
                            Spacer()
                            HStack {
                                if tab == .reserveCake {
                                    Image("cake")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                Text(tab.rawValue)
                                    .foregroundStyle(
                                        tab == .reserveCake ? tab.textColor : (selectedTab == tab ? .black01 : tab.textColor)
                                    )
                                    .font(.pretend(type: .bold, size: 16))
                            }
                            
                            Spacer()
                            // 하단 바
                            Rectangle()
                                .fill(Color.green01)
                                .frame(height: 4)
                                .shadow(color: .black.opacity(0.15), radius: 1, x: 0, y: 3)
                                .opacity(tab == selectedTab ? 1 : 0)
                        }
                        .padding(.horizontal, 16)
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(height: 53)
                        
                    })
                    
                    
                }
            }
            .frame(maxWidth: .infinity, minHeight: 55)
            .padding(.horizontal, 16)
        }
    }
    
    private var storeSheetButton: some View {
        Button(action : {
            viewModel.loadStoreData { result in
                switch result {
                case .success(_):
                    self.showSheet.toggle()
                case .failure(let error):
                    print("error: \(error)")
                }
            }
        }, label: {
            VStack(spacing: 7) {
                HStack {
                    Text("주문할 매장을 선택해 주세요")
                        .font(.MainTextSemiBold16)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal, 20)
                Rectangle()
                    .fill(.gray06)
                    .frame(width: 400, height: 1)
                
            }
            .padding(.vertical, 10)
            .background(.black02)
        })
        .sheet(isPresented: $showSheet, content: {
            SheetView(viewModel: viewModel)
            
        })
        .presentationDetents([.medium])
    }
    
    

}

struct OrderView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            OrderView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

