//
//  ResponseGetInfluencerRoutine.swift
//  Mac_Health
//
//  Created by 최진용 on 11/8/23.
//

import SwiftUI

struct ResponseGetInfluencerRoutine: Codable {
    var part: String
    var numberOfExercise: Int
    var requiredMinutes: Int
    var burnedCalories: Int
    var exercises: [Exercise]
}

struct Exercise: Codable {
    var id: Int
    var name: String
    var exerciseImageUrl: String
    var numberOfSet: Int
}
