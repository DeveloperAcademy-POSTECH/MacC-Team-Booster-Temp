//
//  RecordingWorkoutViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class RecordingWorkoutViewModel: ObservableObject {
    let workoutModel = WorkoutModel()
    
    @Published var nextButtonStatus: NextButtonStatus = .nextSet
    /// 현재 진행 중인 운동
    @Published var exercise = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 0, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    /// 현재 진행 중인 운동 시간
    @Published var workoutTime = ""
    
    /// 현재 진행 중인 운동 세트 인덱스
    @Published var currentSet = 0
    
    /// 현재 진행 중인 운동의 중단 얼럿 여부
    @Published var isStopAlertShow = false
    
    /// 현재 진행 중인 운동 일시 정지 시트 여부
    @Published var isPauseSheetShow = false
    
    /// 운동이 남아있을 때 운동 완료 얼럿 여부
    @Published var isDiscontinuewAlertShow = false
    
    /// 선택한 운동
    @Published var selectedExercise = -1
    
    /// 팁 이미지 전환
    @Published var tabSelection = 0
    
    /// api 응답 받아야 탭 가능하게 전환 - 추후 콤바인 교체
    @Published var isCanTappable = true
    
    @Published var isAlternateWorkoutSheetShow = false
    @Published var isEditWorkoutActionShow = false
    @Published var isDeleteWorkoutAlertShow = false
    
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
    @Published private var startTime = Date.now
    private var timer: Timer?
}

/// 운동 패치
extension RecordingWorkoutViewModel {
    func fetchWorkout(routineId: Int, exerciseId: Int) {
        workoutModel.fetchWorkout(routineId: routineId, exerciseId: exerciseId) {
            self.exercise = $0
        }
    }
}

/// 운동 세트 증감
extension RecordingWorkoutViewModel {
    /// 운동 세트 감소 함수
    func decreaseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (() -> ()) ) {
        if exercise.sets.count > 2 {
            isCanTappable = false
            
            workoutModel.decreaseSetCount(routineId: routineId, exerciseId: exerciseId) {
                if self.currentSet >= $0.count {
                    self.currentSet -= 1
                }
                self.exercise.sets = $0
                self.isCanTappable = true
                completion()
            }
        }
    }
    
    /// 운동 세트 증가 함수
    func increseSetCount(routineId: Int, exerciseId: Int) {
        if exercise.sets.count < 9 {
            isCanTappable = false
            
            workoutModel.increseSetCount(routineId: routineId, exerciseId: exerciseId) {
                self.nextButtonStatus = .nextSet
                self.exercise.sets = $0
                self.isCanTappable = true
            }
        }
    }
    
    /// 세트 무게 편집 함수
    func editWeight(routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> ())) {
        workoutModel.editWeight(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps) {
            completion($0)
        }
    }
    
    /// 세트 횟수 편집 함수
    func editReps(routineId: Int, exerciseId: Int, setId: Int, weight: Int? = nil, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> ())) {
        workoutModel.editReps(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight ?? nil, reps: reps) {
            completion($0)
        }
    }
}

/// 세트 컨트롤
extension RecordingWorkoutViewModel {
    /// 다음 세트 함수
    func nextSet(routineId: Int, exerciseId: Int, setId: Int, completion: @escaping (() -> ())) {
        isCanTappable = false
        
        workoutModel.fisishSet(routineId: routineId, exerciseId: exerciseId, setId: setId) {
            self.isCanTappable = true
            self.exercise.sets[self.currentSet].isDone = true
            
            self.currentSet += 1
            completion()
        }
    }
    
    /// 다음 운동 함수
    func nextWorkout(routineId: Int, exerciseId: Int, setId: Int, completion: @escaping (() -> ())) {
        isCanTappable = false
        
        workoutModel.fisishSet(routineId: routineId, exerciseId: exerciseId, setId: setId) {
            self.isCanTappable = true
            self.exercise.sets[self.currentSet].isDone = true
            self.currentSet = 0
            self.nextButtonStatus = .nextSet
            
            completion()
        }
    }
    
    /// 루틴 완료 함수
    func finishWorkout(routineId: Int, exerciseId: Int, setId: Int, completion: @escaping (() -> ())) {
        isCanTappable = false
        
        workoutModel.fisishSet(routineId: routineId, exerciseId: exerciseId, setId: setId) {
            self.exercise.sets[self.currentSet].isDone = true
            self.isCanTappable = true
            
            completion()
        }
    }
}

/// 스탑워치
extension RecordingWorkoutViewModel {
    func start() {
        isRunning = true
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func stop() {
        isRunning = false
        
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.elapsedTime += 1
            }
        } else {
            timer?.invalidate()
            timer = nil
        }
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

/// 포매터
extension RecordingWorkoutViewModel {
    func finishTimeFormatted(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60
        return if hours >= 1 {
            String(format: "%01d시간%02d분",hours, minutes)
        } else {
            String(format: "%01d분", minutes)
        }
    }
}
