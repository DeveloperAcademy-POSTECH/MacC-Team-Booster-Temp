//
//  Ext+Date.swift
//  beFLE
//
//  Created by 송재훈 on 11/12/23.
//

import SwiftUI

extension Date {
    enum FormatterType {
        /// Date() -> "2023-10-24"
        case yearMonthToday
        /// Date() -> "10월 24일"
        case monthDay
        /// Date() -> "10월 24일 일요일"
        case monthDayWeek
    }
    
    func format(_ type: FormatterType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        switch type {
        case .yearMonthToday:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .monthDay:
            dateFormatter.dateFormat = "MM월 dd일"
        case .monthDayWeek:
            dateFormatter.dateFormat = "MM월 dd일 E요일"
        }
        
        return dateFormatter.string(from: self)
    }
}
