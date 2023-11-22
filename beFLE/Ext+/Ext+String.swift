//
//  Ext+String.swift
//  beFLE
//
//  Created by 송재훈 on 11/12/23.
//

import SwiftUI

extension String {
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
}
