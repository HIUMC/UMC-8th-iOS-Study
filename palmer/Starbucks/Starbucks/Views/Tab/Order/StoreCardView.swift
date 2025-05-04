//
//  StoreCardView.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//
import SwiftUI
import CoreLocation

struct StoreCardView: View {
    let store: StoreModel
    let distance: CLLocationDistance?
    @State var address: String = ""
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(.clear)
                    .border(.gray)
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(width: 84, height: 84)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(store.storeName)
                        .foregroundStyle(Color("black03"))
                        .font(.mainTextSemiBold13)
                    
                    Text(address)
                        .foregroundStyle(Color("gray02"))
                        .font(.pretendardMedium(10))
                }
                    
                HStack {
                    if store.category == "DT 매장" {
                        Image(.drive)
                    } else if store.category == "리저브 매장" {
                        Image(.reserve)
                    }
                    
                    Spacer()
                    
                    if let dist = distance {
                        if dist < 1000 {
                            Text(String(format: "%.0f m", dist)).font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color("black02"))
                                .font(.mainTextMedium12)
                        } else {
                            Text(String(format: "%.1f km", dist / 1000.0)).font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color("black02"))
                                .font(.mainTextMedium12)
                        }
                    }
                }
            }
            .padding(.vertical, 6)
        }
        .task {
            // geojson의 위도와 경도를 가져오기는 하는데, 이걸 반환을... 못함
            let geocoder = CLGeocoder()
            
            let location = CLLocation(latitude: store.yCoordinate, longitude: store.xCoordinate)
            
            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                await MainActor.run {
                    if let placemark = placemarks.first {
                        address = [
                            //                            placemark.administrativeArea,
                            placemark.country,
                            placemark.locality,
                            placemark.subLocality,
                            placemark.thoroughfare
                        ].compactMap { $0 }.joined(separator: " ")
                        
                        print("디코딩된 좌표: 위도=\(store.yCoordinate), 경도=\(store.xCoordinate)")
                        print("주소: \(address)")
                    }
                }
            } catch {
                self.address = store.address
                print("디코딩된 좌표: 위도=\(store.yCoordinate), 경도=\(store.xCoordinate)")
                print("역지오코딩 에러: \(error.localizedDescription)")
            }
        }
    }
}
