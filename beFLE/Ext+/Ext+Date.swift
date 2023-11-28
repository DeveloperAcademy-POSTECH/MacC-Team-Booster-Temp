//
//  Ext+Date.swift
//  beFLE
//
//  Created by 송재훈 on 11/12/23.
//

import SwiftUI

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 EEEE"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: self)
    }
    
    
}

extension Date {
    func formatNow() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 E요일"
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: self)
    }
}
