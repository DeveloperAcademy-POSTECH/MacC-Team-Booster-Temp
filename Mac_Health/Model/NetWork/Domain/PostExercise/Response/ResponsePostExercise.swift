//
//  ResponsePostExercise.swift
//  Mac_Health
//
//  Created by 최진용 on 11/8/23.
//

import SwiftUI

struct ResponsePostExercise: Codable {
    var exercises: [Set]
}

struct Set: Codable {
    var setId: Int
    var weight: Int
    var reps: Int
    var isDone: Bool
}
