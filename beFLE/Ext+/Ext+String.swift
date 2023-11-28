//
//  Ext+String.swift
//  beFLE
//
//  Created by 송재훈 on 11/12/23.
//

import SwiftUI

extension String {
    /// 서버에서 받아온 문자열 형식 날짜를 날짜로 전환해주는 함수
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
    
    /// 전달 받은 "2023-10-24"가 오늘 날짜인지 검사하는 함수
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
    /// 스트링 포매터 타입 종류
    enum FormatterType {
        /// "2023-10-24"를 "23년 10월 24일"로 전환해주는 함수
        case yearMonthDay
        /// "2023-10-24"를 "10월 24일"로 전환해주는 함수
        case monthDay
        /// "2023-10-24"를 "24"로 전환해주는 함수
        case day
    }
    
    func format(to type: FormatterType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        switch type {
        case .yearMonthDay:
            dateFormatter.dateFormat = "YY년 MM월 dd일"
        case .monthDay:
            dateFormatter.dateFormat = "MM월 dd일"
        case .day:
            dateFormatter.dateFormat = "dd"
        }
        
        return dateFormatter.string(from: self.toDate() ?? Date())
    }
}
