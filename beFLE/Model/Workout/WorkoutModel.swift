//
//  WorkoutModel.swift
//  beFLE
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct WorkoutModel {
    var workoutDate: String
    var influencerName: String
    var workoutName: String
    var workoutSet: Int
    var workoutKgs: [Int?]
    var workoutReps: [Int]
    var alternativeWorkout: [String]
    var relatedContentURL: [String]
    var workoutTip: String
}
