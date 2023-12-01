//
//  WorkoutViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/25/23.
//

import SwiftUI

class WorkoutViewModel: ObservableObject {
    let routineModel = RoutineModel()
    let workoutModel = WorkoutModel()
    
    @Published var workoutViewStatus: WorkoutViewStatus = .emptyView
    @Published var routineId = 0
    @Published var exerciseId = 0
    @Published var currentWorkoutIndex = 0
    @Published var routineCompleteImageUrl = ""
    
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    @Published var workout = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 0, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    @Published var workouts: [Int] = []
    
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
            completion()
        case .recordingRoutineView:
            completion()
        case .editRecordingRoutineView:
            completion()
        case .recordingFinishView:
            finishRoutine()
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
        fetchWorkout()
    }
    
    func fetchRoutine() {
        routineModel.fetchRoutine(routineId: routineId) {
            self.routine = $0
            
            if !$0.exercises.isEmpty {
                self.fetchExerciseId(exerciseId: $0.exercises[self.currentWorkoutIndex].id)
            }
        }
    }
    
    func fetchRoutine(completion: @escaping (()->())) {
        routineModel.fetchRoutine(routineId: routineId) {
            self.routine = $0
            
            if !$0.exercises.isEmpty {
                self.fetchExerciseId(exerciseId: $0.exercises[self.currentWorkoutIndex].id)
            }
            completion()
        }
    }
    
    func fetchNextWorkout(completion: @escaping (() -> ())) {
        currentWorkoutIndex += 1
        fetchRoutine() {
            completion()
        }
    }
    
    func fetchWorkout() {
        workoutModel.fetchWorkout(routineId: routineId, exerciseId: exerciseId) {
            self.workout = $0
        }
    }
    
    func deleteWorkout() {
        if routine.exercises.last?.id == exerciseId {
            currentWorkoutIndex -= 1
        }
        
        workoutModel.deleteWorkout(routineId: routineId, exerciseId: exerciseId) {
            self.fetchRoutine()
        }
    }
    
    func deleteWorkout(exerciseId: Int) {
        if exerciseId == self.exerciseId, (currentWorkoutIndex == routine.exercises.count - 2) {
            currentWorkoutIndex -= 1
        }
        
        workoutModel.deleteWorkout(routineId: routineId, exerciseId: exerciseId) {
            self.fetchRoutine()
        }
    }
    
    func deleteWorkout(exerciseId: Int, completion: @escaping (() -> ())) {
        if exerciseId == self.exerciseId, (currentWorkoutIndex == routine.exercises.count - 2) {
            currentWorkoutIndex -= 1
        }
        
        workoutModel.deleteWorkout(routineId: routineId, exerciseId: exerciseId) {
            self.fetchRoutine {
                completion()
            }
        }
    }
    
    func decreaseSetCount(completion: @escaping (() -> ())) {
        if workout.sets.count > 2 {
            workoutModel.decreaseSetCount(routineId: routineId, exerciseId: exerciseId) {
                self.workout.sets = $0
                completion()
            }
        }
        else {
            completion()
        }
    }
    
    func increseSetCount(completion: @escaping (() -> ())) {
        if workout.sets.count < 9 {
            workoutModel.increseSetCount(routineId: routineId, exerciseId: exerciseId) {
                self.workout.sets = $0
                completion()
            }
        }
        else {
            completion()
        }
    }
    
    func finishSet(setId: Int, completion: @escaping (() -> ())) {
        workoutModel.fisishSet(routineId: routineId, exerciseId: exerciseId, setId: setId) {
            completion()
        }
    }
    
    func finishRoutine() {
        routineModel.finishRoutine(routineId: routineId) {
            self.routineCompleteImageUrl = $0
            self.changeViewStatus(.recordingFinishView)
        }
    }
}

/// 타이머 관련
extension WorkoutViewModel {
    func updateWorkoutTime(completion: @escaping (() -> ())) {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        
        let time = DateComponents(hour: hours, minute: minutes, second: seconds)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        
        GeneralAPIManger.request(for: .PatchUsersRoutines(routineId: routineId, time: timeFormatter.string(from: Calendar.current.date(from: time)!))) {
            switch $0 {
            case .success:
                completion()
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
    
    func bgTimer() {
        let curTime = Date.now
        let diffTime = startTime.distance(to: curTime)
        let result = Double(diffTime.formatted())!
        elapsedTime = result
    }
    
    func timeFormatted() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%01d:%02d:%02d",hours, minutes, seconds)
    }
}
