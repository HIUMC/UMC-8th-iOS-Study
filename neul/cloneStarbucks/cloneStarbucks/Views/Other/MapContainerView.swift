//
//  MapContainerView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/1/25.
//

import SwiftUI

struct MapContainerView: View {
    @Bindable var locationManager = LocationManager.shared
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var viewModel: JSONParsingViewModel
    @State var isFindStore: Bool = true
    @StateObject private var mapState = StoreMapStateViewModel()
    
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            segmentMenu
            ZStack(alignment: .bottomTrailing) {
                StoreMapContainerView(locationManager: locationManager, mapState: mapState)
                userLocationButton
            }
            
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            print("이건 돼.")
            if let storeData = viewModel.storeData {
                print("왜.. 안되지?")
                mapViewModel.stores = storeData.features
            }
        }
    }
    
    
    private var navigationBar: some View {
        HStack {
            CustomNavBackButton()
            Spacer()
            Text("매장 찾기")
                .font(.MainTextMedium16)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var segmentMenu: some View {
        GeometryReader { reader in
            VStack(spacing: 0) {
                HStack(spacing: 50) {
                    Spacer()
                    Button(action: {
                        isFindStore = true
                    }, label: {
                        Text("매장 찾기")
                            .font(.MainTextSemiBold24)
                            .foregroundStyle(isFindStore ? Color.black02 : Color.gray06)
                    })
                    Spacer()
                    Button(action: {
                        isFindStore = false
                    }, label: {
                        Text("길찾기")
                            .font(.MainTextSemiBold24)
                            .foregroundStyle(!isFindStore ? Color.black02 : Color.gray06)
                    })
                    Spacer()
                }
                .frame(height: 60)
                HStack {
                    Rectangle()
                        .foregroundStyle(Color.green01)
                        .frame(width: reader.size.width/2)
                        .offset(x: isFindStore ? 0 : reader.size.width / 2)
                        .animation(.easeInOut, value: isFindStore)
                    Spacer()
                }
                .frame(height: 2)
                
            }
            .background(Color.clear)
        }
        .frame(height: 62)
    }
    
    private var userLocationButton: some View {
        Button(action: {
            mapState.shouldMoveToUserLocation = true
        }, label: {
            Circle()
                .fill(Color.white)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: "dot.scope")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color.green02)
                }
            
        })
        .padding(.all, 20)
    }
}




