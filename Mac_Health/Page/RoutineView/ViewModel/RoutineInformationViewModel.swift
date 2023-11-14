//
//  RoutineInformationViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class RoutineInformationViewModel: ObservableObject {
    /// 루틴 목록
    @Published var routine = ""
    
    /// 루틴 정보 조회 함수
    func fetchRoutine() {
        // TODO: 루틴 목록 조회
    }
    
    /// 루틴 부위 별 분류 함수
    func fetchByPart() {
        // TODO: 부위 별 루틴 분류
    }
    
    /// 운동 시작하기 위한 운동 목록 편집 네비게이션 용 함수
    func startWorkout() {
        // TODO: 운동 시작하기
    }
}
