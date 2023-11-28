//
//  Ext+String.swift
//  beFLE
//
//  Created by 송재훈 on 11/12/23.
//

import SwiftUI

extension String {
    /// "2023-10-24" -> Date("2023-10-24")
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        
        if let date = dateFormatter.date(from: self) {
            return date
        }
        else {
            return nil
        }  
    }
    
    /// "2023-10-24" == Date(.now) ? true : false
    func isToday() -> Bool {
        let difference = Calendar.current.dateComponents([.day], from: self.toDate() ?? Date(), to: Date())
        if difference.day == 0 {
            return true
        } else {
            return false
        }
    }
}

extension String {
    enum FormatterType {
        /// "2023-10-24" -> "23년 10월 24일"
        case yearMonthDay
        /// "2023-10-24" -> "10월 24일"
        case monthDay
        /// "2023-10-24" -> "10월 24일 월요일"
        case monthDayWeek
        /// "2023-10-24" -> "24"
        case day
    }
    
    func format(_ type: FormatterType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        switch type {
        case .yearMonthDay:
            dateFormatter.dateFormat = "YY년 MM월 dd일"
        case .monthDay:
            dateFormatter.dateFormat = "MM월 dd일"
        case .monthDayWeek:
            dateFormatter.dateFormat = "MM월 dd일 EEEE"
        case .day:
            dateFormatter.dateFormat = "dd"
        }
        
        return dateFormatter.string(from: self.toDate() ?? Date())
    }
}
