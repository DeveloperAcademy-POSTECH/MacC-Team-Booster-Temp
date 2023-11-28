//
//  Ext+Font.swift
//  beFLE
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
    static func calendarWeek() -> UIFont {
        return UIFont(name: Pretentard.semiBold, size: 13 * setFontSize())!
    }
    static func calendarDate() -> UIFont {
        return UIFont(name: Pretentard.regular, size: 20 * setFontSize())!
    }
    static func calendarTitle() -> UIFont {
        return UIFont(name: Pretentard.semiBold, size: 17 * setFontSize())!
    }
    static func title1() -> Font {
        return Font.custom(Pretentard.semiBold, size: 24 * setFontSize()).weight(.semibold)
    }
    static func title2() -> Font {
        return Font.custom(Pretentard.semiBold, size: 20 * setFontSize()).weight(.semibold)
    }
    static func headline1() -> Font {
        return Font.custom(Pretentard.semiBold, size: 16 * setFontSize()).weight(.semibold)
    }
    static func headline2() -> Font {
        return Font.custom(Pretentard.semiBold, size: 14 * setFontSize()).weight(.semibold)
    }
    static func body() -> Font {
        return Font.custom(Pretentard.regular, size: 16 * setFontSize()).weight(.regular)
    }
    static func body2() -> Font {
        return Font.custom(Pretentard.regular, size: 14 * setFontSize()).weight(.regular)
    }
    static func button1() -> Font {
        return Font.custom(Pretentard.bold, size: 16 * setFontSize()).bold()
    }
    static func button2() -> Font {
        return Font.custom(Pretentard.semiBold, size: 14 * setFontSize()).weight(.semibold)
    }
    static func largeTitle() -> Font {
        return Font.custom(Pretentard.semiBold, size: 36 * setFontSize()).weight(.semibold)
    }
    static func caption() -> Font {
        return Font.custom(Pretentard.regular, size: 12)
    }
    
    ///기기별 폰트 사이즈 대응
    static func setFontSize() -> Double {
        let height = UIScreen.screenHeight
        var size = 1.0
        
        switch height {
        case 480.0: // Iphone 3,4S => 3.5 inch
            size = 0.85
        case 568.0: // iphone 5, SE => 4 inch
            size = 0.9
        case 667.0: // iphone 6, 6s, 7, 8 => 4.7 inch
            size = 0.9
        case 736.0: // iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            size = 0.95
        case 812.0: // iphone X, XS => 5.8 inch, 13 mini, 12, mini
            size = 0.98
        case 844.0: // iphone 14, iphone 13 pro, iphone 13, 12 pro, 12
            size = 1
        case 852.0: // iphone 14 pro
            size = 1
        case 926.0: // iphone 14 plus, iphone 13 pro max, 12 pro max
            size = 1.05
        case 896.0: // iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch, 11 pro max, 11
            size = 1.05
        case 932.0: // iPhone14 Pro Max
            size = 1.08
        default:
            size = 1
        }
        return size
    }
}

extension Font: CaseIterable {
    public static var allCases: [Font] = [.title1(), .title2(), .headline1(), .headline2(), .body(), .body2(), .button1(), .button2(), largeTitle()]
    
    var fontStyle: String {
        switch self {
        case .title1():
            return "title1"
        case .title2():
            return "title2"
        case .headline1():
            return "headline1"
        case .headline2():
            return "headline2"
        case .body():
            return "body"
        case .body2():
            return "body2"
        case .button1():
            return "button1"
        case .button2():
            return "button2"
        case .largeTitle():
            return "largeTitle"
        default:
            return "default"
        }
    }
}

struct Font_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ForEach(Font.allCases, id: \.self) { font in
                Text("\(font.fontStyle)")
                    .font(font)
            }
        }
    }
}
