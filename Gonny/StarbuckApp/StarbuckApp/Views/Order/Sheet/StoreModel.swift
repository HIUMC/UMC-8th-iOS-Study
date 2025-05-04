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
   case both="리저브+DT 매장"
}
/*
import Foundation


import CoreLocation

struct StoreModel:Codable {
   var features: [StoreFeature]
}

struct StoreFeature:Codable,Hashable {
   var properties: StoreProperty
   let geometry: Geometry
    
    var latitude: Double {
           return properties.yCoordinate
       }

       var longitude: Double {
           return properties.xCoordinate
       }

       var coordinate: CLLocationCoordinate2D {
           return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
       }
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

enum StoreCategory: String, Codable {
    case normal
    case reserve
    case dt
    case both

    init(from raw: String) {
        let lower = raw.lowercased()
        switch lower {
        case "reserve": self = .reserve
        case "dt": self = .dt
        case "both": self = .both
        default: self = .normal
        }
    }
}
*/
