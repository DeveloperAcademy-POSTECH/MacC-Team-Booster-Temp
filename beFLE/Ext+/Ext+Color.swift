//
//  Ext+Color.swift
//  beFLE
//
//  Created by 최진용 on 2023/10/19.
//


import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
    
    static let gray_900 = Color(hex: "0C0C0C")
    static let gray_800 = Color(hex: "1C1C1C")
    static let gray_700 = Color(hex: "242424")
    static let gray_600 = Color(hex: "343434")
    static let label_900 = Color(hex: "F5F5F5")
    static let label_800 = Color(hex: "F5F5F5").opacity(0.8)
    static let label_700 = Color(hex: "F5F5F5").opacity(0.6)
    static let label_600 = Color(hex: "F5F5F5").opacity(0.5)
    static let label_500 = Color(hex: "F5F5F5").opacity(0.4)
    static let label_400 = Color(hex: "F5F5F5").opacity(0.2)
    static let fill_1 = Color(hex: "F5F5F5").opacity(0.1)
    static let fill_2 = Color(hex: "F5F5F5").opacity(0.04)
    static let fill_3 = Color(hex: "F5F5F5").opacity(0.02)
    static let green_main = Color(hex: "2ACC7E")
    static let green_10 = Color(hex: "2ACC7E").opacity(0.1)
    static let red_main = Color(hex: "DE4744")
    static let blue_main = Color(hex: "73A3FE")
    static let purple_main = Color(hex: "AB6FF5")
    static let pink_main = Color(hex: "FE7394")
    static let yellow_main = Color(hex: "D9FA48")
    static let dim = Color(hex: "000000").opacity(0.7)
    static let tabbar_main = UIColor(Color(hex: "000000").opacity(0.75))
    static let calendar_week = UIColor(Color(hex: "F5F5F5").opacity(0.7))
    static let calendar_outdated_gray = UIColor(Color(hex: "F5F5F5").opacity(0.8))
    static let calendar_white = UIColor(Color(hex: "F5F5F5"))
}


extension Color: CaseIterable {
    public static var allCases: [Color] = [.gray_900, .gray_800, .gray_800, .gray_700, .gray_600, .label_900, .label_800, .label_700, .label_600, .label_500, .label_400, .fill_1, .fill_2, .fill_3, .green_main, .green_10, .red_main, .blue_main, .purple_main, .pink_main, .yellow_main, .dim, Color(uiColor: Color.tabbar_main)]
    
    var colorStyle: String {
        switch self {
        case .gray_900:
            return "gray_900"
        case .gray_800:
            return "gray_800"
        case .gray_700:
            return "gray_700"
        case .gray_600:
            return "gray_600"
        case .label_900:
            return "label_900"
        case .label_800:
            return "label_800"
        case .label_700:
            return "label_700"
        case .label_600:
            return "label_600"
        case .label_500:
            return "label_500"
        case .label_400:
            return "label_400"
        case .fill_1:
            return "fill_1"
        case .fill_2:
            return "fill_2"
        case .fill_3:
            return "fill_3"
        case .gray_900:
            return "gray_900"
        case .green_main:
            return "green_main"
        case .green_10:
            return "green_10"
        case .red_main:
            return "red_main"
        case .blue_main:
            return "blue_main"
        case .purple_main:
            return "purple_main"
        case .pink_main:
            return "pink_main"
        case .yellow_main:
            return "yellow_main"
        case .dim:
            return "dim"
        case Color(uiColor: Color.tabbar_main):
            return "tabbar_main"
        default:
            return "default"
        }
    }
}

