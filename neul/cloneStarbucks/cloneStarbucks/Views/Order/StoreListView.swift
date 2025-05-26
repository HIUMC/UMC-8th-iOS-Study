//
//  StoreListView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//

import SwiftUI

struct StoreListView: View {
    var stores: [StoreFeature] = []
    @EnvironmentObject var viewModel: MapViewModel
    @StateObject private var imageViewModel: StoreImageViewModel = .init()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(Array(viewModel.displayedStores.enumerated()), id: \.element) { index, store in
                    StoreCell(
                        storeName: store.storeName,
                        storeAddress: store.address,
                        category: store.category,
                        distance: store.distance,
                        imageData: store.imageData
                    )
                    .onAppear {
                        Task {
                            if store.imageData == nil {
                                let fetchedData = try await imageViewModel.getStoreInfo(query: store.storeName + " 스타벅스")
                                viewModel.displayedStores[index].imageData = fetchedData
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 32.5)
        .onAppear {
            Task {
                await viewModel.setStoresAndUpdate(stores)
            }
        }
    }
    
}


