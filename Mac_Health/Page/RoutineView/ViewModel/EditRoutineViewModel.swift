//
//  EditRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class EditRoutineViewModel: ObservableObject {
    // TODO: 전달 받은 운동 보여주기 - 패치하거나, 상위 뷰에서 받아오기
    /// 운동 목록
    @Published var routine: String = ""
    
    /*
     routine은 RoutineInformationView에서 전달 받은 루틴 1개
     또는 SingleInfluencerRoutineView에서 전달 받은 루틴 1개
     */
    
    /// 선택한 운동의 상세 정보 시트 여부
    @Published var isDetailedWorkoutSheetShow = false
    
    /// 선택한 운동의 대체 또는 삭제 여부
    @Published var isEditWorkoutActionShow = false
    
    /// 선택한 운동의 대체 시트 여부
    @Published var isAlternateWorkoutSheetShow = false
    
    /// 선택한 운동의 삭제 얼럿 여부
    @Published var isDeleteWorkoutAlertShow = false
    
    /// 운동 목록 조회
    func fetchRoutine() {
        // TODO: 운동 목록 조회하기
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
