//
//  MyModel.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//
struct MyModel: Codable, Identifiable, Hashable {
    let seq: String
    var id: String { seq }
    let storeName: String
    let latitude: Double
    let longitude: Double
    let address: String

    enum CodingKeys: String, CodingKey {
        case properties
    }

    enum PropertiesKeys: String, CodingKey {
        case seq = "Seq"
        case storeName = "Sotre_nm"
        case address = "Address"
        case latitude = "Ycoordinate"
        case longitude = "Xcoordinate"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let props = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
        seq = try props.decode(String.self, forKey: .seq)
        storeName = try props.decode(String.self, forKey: .storeName)
        address = try props.decode(String.self, forKey: .address)
        latitude = try props.decode(Double.self, forKey: .latitude)
        longitude = try props.decode(Double.self, forKey: .longitude)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var props = container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
        try props.encode(seq, forKey: .seq)
        try props.encode(storeName, forKey: .storeName)
        try props.encode(address, forKey: .address)
        try props.encode(latitude, forKey: .latitude)
        try props.encode(longitude, forKey: .longitude)
    }
}

