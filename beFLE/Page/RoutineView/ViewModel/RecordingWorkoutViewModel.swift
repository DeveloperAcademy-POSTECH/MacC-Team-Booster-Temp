//
//  RecordingWorkoutViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class RecordingWorkoutViewModel: ObservableObject {
    /// 현재 진행 중인 운동
    
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
    
    /// 루틴 완료 여부
    @Published var isFinish = false
    
    //MARK: 선택한 운동: 선택한 운동 받아오기 - YONG
    @Published var selectedExercise = -1
    
    //팁 이미지 전환
    @Published var tabSelection = 0
    
    /// api 응답 받아야 탭 가능하게 전환 - 추후 콤바인 교체
    @Published var isCanTappable = true
    
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning: Bool = false
    private var timer: Timer?
    
    /// 운동 시간 일시 정지 함수
    func pauseWorkout() {
        
    }
    
    /// 운동 팁 조회 함수
    func showTip() {
        
    }
    
    /// 운동 세트 감소 함수
    func decreaseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> ())) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let sets):
                completion(sets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 세트 증가 함수
    func increseSetCount(routineId: Int, exerciseId: Int, completion: @escaping (([ExerciseSet]) -> ())) {
        GeneralAPIManger.request(for: .PostRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId), type: [ExerciseSet].self) {
            switch $0 {
            case .success(let sets):
                completion(sets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 세트 무게 편집 함수
    func editWeight(index: Int, routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> ())) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                completion(set)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 세트 횟수 편집 함수
    func editReps(index: Int, routineId: Int, exerciseId: Int, setId: Int, weight: Int? = nil, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> ())) {
        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSets(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps), type: ResponsePatchUsersRoutinesExercisesSets.self) {
            switch $0 {
            case .success(let set):
                completion(set)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 현재 세트 완료 함수
    func finishSet(routineId: Int, exerciseId: Int, setId: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSetsFinish) -> ())) {
        isCanTappable = false

        GeneralAPIManger.request(for: .PatchUsersRoutinesExercisesSetsFinish(routineId: routineId, exerciseId: exerciseId, setId: setId), type: ResponsePatchUsersRoutinesExercisesSetsFinish.self) {
            switch $0 {
            case .success(let set):
                self.isCanTappable = true
                completion(set)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 다음 운동 이동 네비게이션 용 함수
    func nextWorkout() {
        
    }
    
    /// 운동 완료 함수
    func finishWorkout(routineId: Int) {
        isCanTappable = false
        
        GeneralAPIManger.request(for: .PatchUsersRoutinesFinish(routineId: routineId), type: ResponsePatchUsersRoutinesFinish.self) {
            switch $0 {
            case .success:
                self.isCanTappable = true
                self.isFinish = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 현재 운동 목록 네비게이션 용 함수
    func viewRoutine() {
        
    }
    
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
    
    func timeFormatted() -> String {
        let hours = Int(elapsedTime) / 3600
        let minutes = Int(elapsedTime) / 60 % 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%01d:%02d:%02d",hours, minutes, seconds)
    }
    
    func finishTimeFormatted(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        return if hours >= 1 {
            String(format: "%01d시간%02d분",hours, minutes)
        } else {
            String(format: "%01d분", minutes)
        }
    }
    
    func getNowDateTime() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  "ko")
        
        dateFormatter.dateFormat = "MM월 dd일"
        let date_String = dateFormatter.string(from: nowDate)
        return date_String
    }
    
}
