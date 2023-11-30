//
//  WorkoutViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/25/23.
//

import SwiftUI

class WorkoutViewModel: ObservableObject {
    let routineModel = RoutineModel()
    let exerciseModel = ExerciseModel()
    
    @Published var workoutViewStatus: WorkoutViewStatus = .emptyView
    @Published var routineId = 0
    @Published var exerciseId = 0
    @Published var currentWorkoutIndex = 0
    @Published var routineCompleteImageUrl = ""
    
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    @Published var exercise = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 0, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    @Published var exercises: [Int] = []
    
    @Published var isRunning = false
    @Published var elapsedTime: TimeInterval = 0
    @Published private var startTime = Date.now
    private var timer: Timer?
}

/// 뷰 상태 전환
extension WorkoutViewModel {
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

/// 운동 데이터 관련
extension WorkoutViewModel {
    func fetchRoutineId(routineId: Int) {
        self.routineId = routineId
        fetchRoutine()
    }
    
    func fetchExerciseId(exerciseId: Int) {
        self.exerciseId = exerciseId
        fetchExercise()
    }
    
    func fetchRoutine() {
        routineModel.fetchRoutine(routineId: routineId) {
            self.routine = $0
            var exercises: [Int] = []
            for exercise in $0.exercises {
                exercises.append(exercise.id)
            }
            self.exercises = exercises
            if !exercises.isEmpty {
                self.fetchExerciseId(exerciseId: exercises[self.currentWorkoutIndex])
            }
        }
    }
    
    func fetchRoutine(completion: @escaping (()->())) {
        routineModel.fetchRoutine(routineId: routineId) {
            self.routine = $0
            var exercises: [Int] = []
            for exercise in $0.exercises {
                exercises.append(exercise.id)
            }
            self.exercises = exercises
            if !exercises.isEmpty {
                self.fetchExerciseId(exerciseId: exercises[self.currentWorkoutIndex])
            }
            completion()
        }
    }
    
    func fetchNextWorkout() {
        currentWorkoutIndex += 1
        fetchRoutine()
    }
    
    func fetchExercise() {
        exerciseModel.fetchExercise(routineId: routineId, exerciseId: exerciseId) {
            self.exercise = $0
        }
    }
    
    func deleteWorkout(exerciseId: Int) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId)) {
            switch $0 {
            case .success:
                self.fetchRoutine()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWorkout(exerciseId: Int, completion: @escaping (() -> ())) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId)) {
            switch $0 {
            case .success:
                self.fetchRoutine() {
                    completion()
                }
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
}

/// 타이머 관련
extension WorkoutViewModel {
    func updateWorkoutTime() {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        
        let time = DateComponents(hour: hours, minute: minutes, second: seconds)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        GeneralAPIManger.request(for: .PatchUsersRoutines(routineId: routineId, time: timeFormatter.string(from: Calendar.current.date(from: time)!))) {
            switch $0 {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func timerStart() {
        if !isRunning {
            isRunning = true
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.isRunning {
                    self.elapsedTime += 1
                }
                else {
                    timer.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    
    func timerStop() {
        isRunning = false
    }
    
    func bgTimer() -> TimeInterval {
        let curTime = Date.now
        let diffTime = startTime.distance(to: curTime)
        let result = Double(diffTime.formatted())!
        elapsedTime = result + elapsedTime
        
        return elapsedTime
    }
    
    func timeFormatted() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%01d:%02d:%02d",hours, minutes, seconds)
    }
}
