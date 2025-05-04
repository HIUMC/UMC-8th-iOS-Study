//
//  StoreListView.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/1/25.
//

import SwiftUI

struct StoreListView: View {
    var stores : [StoreFeature] = []
    @Bindable var viewModel: MapViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.stores, id: \.self) { store in
                    StoreCircle(
                        storeName: store.properties.storeName,
                        storeAddress: store.properties.address,
                        category: store.properties.category,
                        distance: 0
                    )
                }
            }
            .padding(.horizontal, 32.5)
            .border(Color.red)
        }
        
        }
    }

#Preview {
    StoreListView(viewModel: MapViewModel())
}
