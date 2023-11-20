//
//  RecordingFinishViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordingFinishViewModel: ObservableObject {

    func nowDateFormatter() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  "ko")
        
        dateFormatter.dateFormat = "yy.MM.dd"
        let date_String = dateFormatter.string(from: nowDate)
        return date_String
    }
}
