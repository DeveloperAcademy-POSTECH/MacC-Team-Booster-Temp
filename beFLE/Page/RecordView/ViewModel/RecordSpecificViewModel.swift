//
//  RecordSpecificViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordSpecificViewModel: ObservableObject {
    func dateFormat(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY년 MM월 dd일"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    func timeFormat(from time: String) -> String {
        let split = time.split(separator: ":")
        let hour = Int(split[0])!
        let miniute = Int(split[1])!
        let second = Int(split[2])!
        
        return "\(hour)시간 \(miniute)분 \(second)"
    }
}
