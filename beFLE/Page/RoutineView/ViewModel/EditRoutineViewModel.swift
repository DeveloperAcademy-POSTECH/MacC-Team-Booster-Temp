//
//  EditRoutineViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class EditRoutineViewModel: ObservableObject {
    /// 선택한 운동에 대한 Id
    @Published var selectedExerciseId = 0
    
    /// 액션 시트에 보여줄 운동 이름
    @Published var editWorkoutName = ""
    
    /// 선택한 운동의 대체 시트 여부
    @Published var isAlternateWorkoutSheetShow = false
    
    /// 선택한 운동의 삭제 얼럿 여부
    @Published var isDeleteWorkoutAlertShow = false
    
    /// 선택한 운동의 상세 정보 시트 여부
    @Published var isDetailedWorkoutSheetShow = false
    
    /// 선택한 운동의 대체 또는 삭제 여부
    @Published var isEditWorkoutActionShow = false
}
