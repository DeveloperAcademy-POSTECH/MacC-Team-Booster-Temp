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
    enum FormatterType {
        /// 오늘 날짜를 "10월 24일"로 바꿔주는 함수
        case monthDay
        /// 오늘 날짜를 "10월 24일 일요일"로 바꿔주는 함수
        case monthDayWeek
    }
    
    func formatNow(to type: FormatterType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        switch type {
        case .monthDay:
            dateFormatter.dateFormat = "MM월 dd일"
        case .monthDayWeek:
            dateFormatter.dateFormat = "MM월 dd일 E요일"
        }
        
        return dateFormatter.string(from: self)
    }
}
