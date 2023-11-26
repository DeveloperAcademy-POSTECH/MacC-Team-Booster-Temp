//
//  EditRecordingRoutineViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/26/23.
//

import SwiftUI

class EditRecordingRoutineViewModel: ObservableObject {
    /// 운동 목록
    @Published var routine = ResponseGetUsersRoutinesId(part: "", numberOfExercise: 0, requiredMinutes: 0, burnedKCalories: 0, exercises: [])
    
    /// 선택한 운동의 상세 정보 시트 여부
    @Published var isDetailedWorkoutSheetShow = false
    @Published var selectedExerciseId = 0
    
    /// 선택한 운동의 대체 또는 삭제 여부
    @Published var isEditWorkoutActionShow = false
    @Published var editWorkoutName = ""
    
    /// 선택한 운동의 대체 시트 여부
    @Published var isAlternateWorkoutSheetShow = false
    
    /// 선택한 운동의 삭제 얼럿 여부
    @Published var isDeleteWorkoutAlertShow = false
    
    @Published var selectedIndex = 0
    
    /// 운동 목록 조회
    func fetchRoutine(routineId: Int) {
        GeneralAPIManger.request(for: .GetUsersRoutinesId(id: routineId), type: ResponseGetUsersRoutinesId.self) {
            switch $0 {
            case .success(let routine):
                if let routine = routine {
                    self.routine = routine
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWorkout(routineId: Int, exerciseId: Int) {
        GeneralAPIManger.request(for: .DeleteRoutinesExercises(routineId: routineId, exerciseId: exerciseId)) {
            switch $0 {
            case .success:
                self.fetchRoutine(routineId: routineId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
