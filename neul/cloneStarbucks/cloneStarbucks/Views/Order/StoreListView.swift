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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.sortedStoresByDistance(), id: \.self) { store in
                    StoreCell(
                        storeName: store.properties.storeName,
                        storeAddress: store.properties.address,
                        category: store.properties.category,
                        distance: viewModel.distance(to: store) ?? 0.0)
                }
            }
        }
        .padding(.horizontal, 32.5)
        .onAppear {
            viewModel.stores = stores
        }
    }
    
}
