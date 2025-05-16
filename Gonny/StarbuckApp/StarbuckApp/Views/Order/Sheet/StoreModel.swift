//
//  OrderSheetModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
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
       case storeName = "Sotre_nm"
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

enum StoreCategory : String, Codable {//geoJSON txt형식이랑 맞춰줘야 돼...
   case none = ""
   case reserve = "리저브 매장"
   case dt = "DT 매장"
   case dtr = "DTR 매장"
    
}

