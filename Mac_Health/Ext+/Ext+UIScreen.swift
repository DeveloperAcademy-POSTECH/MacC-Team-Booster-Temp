//
//  Ext+UIScreen.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
    
    ///피그마 가로 사이즈를 현재 기기 너비에 맞게 대응해주는 함수입니다.
    static func getWidth(_ width: CGFloat) -> CGFloat {
        screenWidth / 390 * width
    }
    ///피그마 사이즈를 현재 기기 높이에 맞게 대응해주는 함수입니다.
    static func getHeight(_ height: CGFloat) -> CGFloat {
        screenHeight / 844 * height
    }
}

