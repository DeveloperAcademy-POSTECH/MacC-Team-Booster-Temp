//
//  EditRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class EditRoutineViewModel: ObservableObject {
    /// 운동 목록
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    /// 선택한 운동의 상세 정보 시트 여부
    @Published var isDetailedWorkoutSheetShow = false
    
    /// 선택한 운동의 대체 또는 삭제 여부
    @Published var isEditWorkoutActionShow = false
    
    /// 선택한 운동의 대체 시트 여부
    @Published var isAlternateWorkoutSheetShow = false
    
    /// 선택한 운동의 삭제 얼럿 여부
    @Published var isDeleteWorkoutAlertShow = false

    @Published var selectedExercise = 0
    
    @Published var onGoingExercise = 0
    
    @Published var workout = ResponseGetRoutinesExercises(name: "", part: "", exerciseId: 1, exerciseImageUrl: "", tip: "", videoUrls: [], sets: [], alternativeExercises: [], faceImageUrl: "")
    
    /// 운동 목록 조회
    func fetchRoutine(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                self.routine = routine
                print(self.routine)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
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
    
    /// 운동 부위 별 분류 함수
    func fetchByPart() {
        // TODO: 부위 별로 운동 분류하기
    }
    
    /// 운동 시작 네비게이션 용 함수
    func startWorkout() {
        // TODO: 운동 시작하기
    }
}
