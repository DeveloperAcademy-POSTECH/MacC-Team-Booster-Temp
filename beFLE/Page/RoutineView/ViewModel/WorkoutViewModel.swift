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
    @Published var currentWorkoutIndex = 0
    @Published var routineCompleteImageUrl = ""
    
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    @Published var exercise = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 0, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
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
                self.fetchExerciseId(exerciseId: exercises[self.currentWorkoutIndex])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextWorkout() {
        currentWorkoutIndex += 1
        fetchRoutine()
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
    
    func deleteWorkout(exerciseId: Int)  {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success:
                self.fetchRoutine()
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func finishWorkout() {
        GeneralAPIManger.request(for: .PatchUsersRoutinesFinish(routineId: routineId), type: ResponsePatchUsersRoutinesFinish.self) {
            switch $0 {
            case .success(let response):
                self.routineCompleteImageUrl = response.routineCompleteImageUrl
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeViewStatus(_ workoutViewStatus: WorkoutViewStatus) {
        didChangeViewStatus(workoutViewStatus) {
            self.workoutViewStatus = workoutViewStatus
        }
    }
    
    func didChangeViewStatus(_ workoutViewStatus: WorkoutViewStatus, completion: @escaping (() -> ())) {
        switch workoutViewStatus {
        case .emptyView:
            fetchRoutineId(routineId: routineId)
            completion()
        case .editRoutineView:
            completion()
        case .recordingWorkoutView:
            if !exercises.isEmpty {
                completion()
            }
        case .recordingRoutineView:
            completion()
        case .editRecordingRoutineView:
            completion()
        case .recordingFinishView:
            finishWorkout()
            completion()
        }
    }
}
