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
    @Published var exercises: [ResponseGetRoutinesExercises] = []
    
    
    func fetchRoutineId(routineId: Int) {
        self.routineId = routineId
        fetchExercises()
    }
    
    func fetchExerciseId(exerciseId: Int) {
        self.exerciseId = exerciseId
    }
    
    func fetchRoutine() {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.routine = routine
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchExercises() {
        var exercises: [ResponseGetRoutinesExercises] = []
        
        for exercise in routine.exercises {
            GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exercise.id), type: ResponseGetRoutinesExercises.self) {
                switch $0 {
                case .success(let workout):
                    exercises.append(workout)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        self.exercises = exercises
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
