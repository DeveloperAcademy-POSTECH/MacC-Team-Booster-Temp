//
//  RecordSpecificViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/21/23.
//

import SwiftUI

class RecordSpecificViewModel: ObservableObject {
    func timeFormat(from time: String) -> String {
        let split = time.split(separator: ":")
        let hour = Int(split[0])!
        let miniute = Int(split[1])!
        let second = Int(split[2])!
        
        return "\(hour)시간 \(miniute)분 \(second)초"
    }
}
