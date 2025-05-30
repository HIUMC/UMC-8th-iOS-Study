//
//  MapListView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/29/25.
//

import SwiftUI
import Kingfisher

struct MapListView: View {
    @Environment(MapListViewModel.self) var viewModel
    @State private var imageURL: URL?
    
    var body: some View {
        VStack {
            
            content
        }
        .frame(minWidth: UIScreen.screenSize.width - 32.5, maxWidth: UIScreen.screenSize.width - 28)
        .padding(.top, 20)
    }
    
    private var content: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 15) {
                if viewModel.filteredStores.isEmpty {
                    Text("No stores found")
                } else {
                    ForEach(viewModel.filteredStores) { store in
                        MapListCard(store)
                    }
                }
            }
        }
    }
    
    private func MapListCard(_ store: MapListModel) -> some View {
        
        HStack {
            if let url = viewModel.imageURL[store.id] {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 83, height: 83)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            } else {
                Color.gray00.frame(width: 83, height: 83)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .onAppear {
                        viewModel.getPhotoURL(for: store)
                    }
            }
               
            
            Spacer().frame(width: 13)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(store.name)
                    .font(.PretendardRegular13)
                    .foregroundStyle(.black)
                
                Text(store.address)
                    .lineLimit(1)
                    .font(.PretendardRegular12)
                    .foregroundStyle(.gray)
                
                Spacer().frame(height: 12)
                
                HStack {
                    HStack {
                        let storeCategory = StoreCategory(from: store.category)
                        
                        HStack {
                            ForEach(storeCategory.icons, id: \.self) { icon in
                                Image(uiImage: icon)
                            }
                        }
                        
                        Spacer()
                        
                        if let distance = store.distance {
                            if distance < 1000 {
                                Text(String(format: "%.0f m", distance))
                                    .font(.PretendardRegular12)
                                    .foregroundStyle(.black)
                            } else {
                                Text(String(format: "%.2f km", distance/1000))
                                    .font(.PretendardRegular12)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
            }.frame(minHeight: 83)
        }
    }
}

#Preview {
    MapListView()
}
