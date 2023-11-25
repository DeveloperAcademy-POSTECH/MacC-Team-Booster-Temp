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
    @Published var exercise: ResponseGetRoutinesExercises?
    @Published var exercises: [Int] = []
    
    
    func fetchRoutineId(routineId: Int) {
        self.routineId = routineId
        fetchRoutine()
    }
    
    func fetchExerciseId(exerciseId: Int) {
        self.exerciseId = exerciseId
        fetchExercise()
    }
    
    func fetchRoutine() {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.routine = routine
                
                var exercises: [Int] = []
                for exercise in routine.exercises {
                    exercises.append(exercise.id)
                }
                self.exercises = exercises
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchExercise() {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let exercise):
                self.exercise = exercise
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWorkout(routineId: Int, exerciseId: Int)  {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success:
                // TODO: 석세스 nil 처리
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeViewStatus(_ workoutViewStatus: WorkoutViewStatus) {
        self.workoutViewStatus = workoutViewStatus
    }
}
