//
//  Ext+Date.swift
//  Mac_Health
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
