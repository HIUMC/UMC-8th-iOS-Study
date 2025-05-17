import SwiftUI

struct Menu: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}

class OrderViewModel: ObservableObject {
    @Published var menus: [Menu] = []

    init() {
        loadMenus()
    }

    private func loadMenus() {
        self.menus = [
            Menu(imageName: "img(1)", title: "추천", subtitle: "Recommend"),
            Menu(imageName: "img(2)", title: "아이스 카페 아메리카노", subtitle: "Reserve Espresso"),
            Menu(imageName: "img(3)", title: "카페 아메리카노", subtitle: "Reserve Drip"),
            Menu(imageName: "img(4)", title: "카푸치노", subtitle: "Decaf Coffee"),
            Menu(imageName: "img(5)", title: "아이스 카푸치노", subtitle: "Espresso"),
            Menu(imageName: "img(6)", title: "카라멜 마키아또", subtitle: "Blonde Coffee"),
            Menu(imageName: "img(7)", title: "아이스 카라멜 마키아또", subtitle: "Cold Brew"),
            Menu(imageName: "img(8)", title: "아포가토/기타", subtitle: "Others"),
            Menu(imageName: "img(9)", title: "럼 샷 코르타도", subtitle: "Brewed Coffee"),
            Menu(imageName: "img(10)", title: "라벤더 카페 브레베", subtitle: "Teavana"),
            Menu(imageName: "img(11)", title: "병음료", subtitle: "RTD")
        ]
    }
}
