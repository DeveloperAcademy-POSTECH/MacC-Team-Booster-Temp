//
//  TodayStartViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/9/23.
//

import SwiftUI

class TodayStartViewModel: ObservableObject {
    func dateFormat(from date: String) -> String {
        if let date = date.toDate() {
            return date.toString()
        }
        else {
            return date
        }
    }
}
