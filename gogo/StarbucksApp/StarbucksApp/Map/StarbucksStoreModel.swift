//
//  StarbucksStoreModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/1/25.
//

import Foundation


import CoreLocation

struct StarbucksStoreModel:Codable {
   var features: [StoreFeature]
}

struct StoreFeature:Codable,Hashable {
   var properties: StoreProperty
   let geometry: Geometry
}

struct StoreProperty: Codable,Hashable {
   let storeId: String
   let storeName: String
   let address: String
   let telephone: String
   let category: StoreCategory
   let yCoordinate: Double
   let xCoordinate: Double
   
   
   
   var resolvedAddress: String? = nil
   
   enum CodingKeys: String, CodingKey {
       case storeId = "Seq"
       case storeName = "Store_nm"
       case address = "Address"
       case telephone = "Telephone"
       case category = "Category"
       case yCoordinate = "Ycoordinate"
       case xCoordinate = "Xcoordinate"
       
   }
}


struct Geometry : Codable, Hashable {
   let type: String
   let coordinates: [Double]
}

enum StoreCategory : String, Codable {
   case none = ""
   case reserve = "리저브 매장"
   case dt = "DT 매장"
}

struct Marker : Identifiable {
   let id = UUID()
   let coordinate : CLLocationCoordinate2D
   let title: String
}

