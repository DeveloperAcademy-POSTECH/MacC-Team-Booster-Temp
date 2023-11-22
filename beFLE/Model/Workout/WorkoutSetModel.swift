//
//  WorkoutSetModel.swift
//  beFLE
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

struct WorkoutSetModel: Identifiable {
    var id = UUID()
    
    var index: Int
    var kg: Int?
    var repetition: Int
    var isFinish: Bool
}
