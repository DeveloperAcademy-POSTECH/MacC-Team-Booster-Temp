//
//  RecordingWorkoutViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class RecordingWorkoutViewModel: ObservableObject {
    /// 현재 진행 중인 운동
    @Published var workout = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    
    /// 현재 진행 중인 운동 시간
    @Published var workoutTime = ""
    
    /// 현재 진행 중인 운동 세트 인덱스
    @Published var currentSet = ""
    
    /// 현재 진행 중인 운동의 상세 정보 시트 여부
    @Published var isDetailedWorkoutSheetShow = false
    
    /// 현재 진행 중인 운동의 대체 또는 삭제 여부
    @Published var isEditWorkoutActionShow = false
    
    /// 현재 진행 중인 운동의 대체 시트 여부
    @Published var isAlternateWorkoutSheetShow = false
    
    /// 현재 진행 중인 운동의 삭제 얼럿 여부
    @Published var isDeleteWorkoutAlertShow = false
    
    /// 현재 진행 중인 운동의 중단 얼럿 여부
    @Published var isStopAlertShow = false
    
    /// 현재 진행 중인 운동 일시 정지 시트 여부
    @Published var isPauseSheetShow = false
    
    /// 운동이 남아있을 때 운동 완료 얼럿 여부
    @Published var isDiscontinuewAlertShow = false
    
    
    /// 현재 진행 중인 운동 정보 조회 함수
    func fetchWorkout(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .GetRoutinesExercises(routineId: routineId, exerciseId: exerciseId), type: ResponseGetRoutinesExercises.self) {
            switch $0 {
            case .success(let workout):
                self.workout = workout
                print(self.workout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 운동 시간 일시 정지 함수
    func pauseWorkout() {
        
    }
    
    /// 운동 팁 조회 함수
    func showTip() {
        
    }
    
    /// 운동 세트 감소 함수
    func decreaseSetCount() {
        
    }
    
    /// 운동 세트 증가 함수
    func increseSetCount() {
        
    }
    
    /// 무게 편집 함수
    func editWeight() {
        
    }
    
    /// 횟수 편집 함수
    func editRepetition() {
        
    }
    
    /// 현재 세트 완료 함수
    func finishSet() {
        
    }
    
    /// 다음 운동 이동 네비게이션 용 함수
    func nextWorkout() {
        
    }
    
    /// 운동 완료 함수
    func finishWorkout() {
        
    }
    
    /// 현재 운동 목록 네비게이션 용 함수
    func viewRoutine() {
        
    }
}
