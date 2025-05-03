//
//  NewProductsViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//

import Foundation

class NewProductsViewModel: ObservableObject {
    
    @Published var newproducts: [NewProductsModel] = [
        NewProductsModel(newProductsImageName: "newProduct1", newProductsName: "그린 사이렌 도트 머그\n237ml"),
        NewProductsModel(newProductsImageName: "newProduct2", newProductsName: "그린 사이렌 도트 머그\n355ml"),
        NewProductsModel(newProductsImageName: "newProduct3", newProductsName: "홈 카페 미니 머그 세트"),
        NewProductsModel(newProductsImageName: "newProduct4", newProductsName: "홈 카페 글라스 세트")
    ]
}
