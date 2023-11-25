//
//  WorkoutViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/25/23.
//

import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var workoutViewStatus: WorkoutViewStatus = .emptyView
    @Published var routineId = 0
    @Published var exerciseId = 0
    
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    @Published var workout = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    
    
    func fetchRoutineId(routineId: Int) {
        self.routineId = routineId
    }
    
    func fetchExerciseId(exerciseId: Int) {
        self.exerciseId = exerciseId
    }
    
    func changeViewStatus(_ workoutViewStatus: WorkoutViewStatus) {
        self.workoutViewStatus = workoutViewStatus
    }
}
