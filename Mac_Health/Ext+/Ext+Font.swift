//
//  Ext+Font.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

struct Pretentard {
    static let bold = "Pretendard-Bold"
    static let extraBold = "Pretendard-ExtraBold"
    static let extraLight = "Pretendard-ExtraLight"
    static let light = "Pretendard-Light"
    static let regular = "Pretendard-Regular"
    static let medium = "Pretendard-Medium"
    static let semiBold = "Pretendard-SemiBold"
    static let thin = "Pretendard-Thin"
}

extension Font {
    func title1() -> Font {
        Font.custom(Pretentard.semiBold, size: 24)
    }
    func title2() -> Font {
        Font.custom(Pretentard.semiBold, size: 20)
    }
    func headline1() -> Font {
        Font.custom(Pretentard.semiBold, size: 16)
    }
    func headline2() -> Font {
        Font.custom(Pretentard.semiBold, size: 14)
    }
    func body() -> Font {
        Font.custom(Pretentard.regular, size: 16)
    }
    func body2() -> Font {
        Font.custom(Pretentard.semiBold, size: 14)
    }
    func button1() -> Font {
        Font.custom(Pretentard.bold, size: 16)
    }
    func button2() -> Font {
        Font.custom(Pretentard.semiBold, size: 14)
    }
}

extension Font {
    enum fontExtention: String {
        case otf
        case ttf
    }
    
    static func registeFonts() {
        self.register(name: Pretentard.bold, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.extraBold, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.light, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.regular, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.semiBold, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.extraLight, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.medium, withExtension: fontExtention.otf.rawValue)
        self.register(name: Pretentard.thin, withExtension:fontExtention.otf.rawValue)
    }
    
    static func register(name: String, withExtension: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: withExtension),CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        else {
            return print("failed to regist \(name) font")
        }
    }
}
