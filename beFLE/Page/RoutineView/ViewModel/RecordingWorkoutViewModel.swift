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
    @Published var isTappable = true
    
    @Published var isAlternateWorkoutSheetShow = false
    @Published var isEditWorkoutActionShow = false
    @Published var isDeleteWorkoutAlertShow = false
}

/// 운동 세트 증감
extension RecordingWorkoutViewModel {
    /// 세트 무게 편집 함수
    func editWeight(routineId: Int, exerciseId: Int, setId: Int, weight: Int, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> Void)) {
        workoutModel.editWeight(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps) { result in
            completion(result)
        }
    }
    
    /// 세트 횟수 편집 함수
    func editReps(routineId: Int, exerciseId: Int, setId: Int, weight: Int? = nil, reps: Int, completion: @escaping ((ResponsePatchUsersRoutinesExercisesSets) -> Void)) {
        workoutModel.editReps(routineId: routineId, exerciseId: exerciseId, setId: setId, weight: weight, reps: reps) { result in
            completion(result)
        }
    }
}
