//
//  WholeRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class WholeRoutineViewModel: ObservableObject {
    // TODO: 루틴 모델 변경
    /// 전체 루틴 목록
    @Published var routines: [String] = []
    
    /*
     routines는 인플루언서 아이디로 검색한 모든 루틴 목록
     SingleInfluencerRoutineView에 1개 전달
     */
    
    // TODO: 루틴 부위들 추가
    /// 선택된 부위
    @Published var selectedPart: String = ""
    
    /// 전체 루틴 조회 함수
    func fetchRoutines(influencerId: Int) {
        // TODO: 루틴 목록 조회
    }
    
    /// 루틴 월 별 분류 함수
    func fetchByMonth() {
        // TODO: 월 별 루틴 분류
    }
    
    /// 루틴 부위 별 분류 함수
    func fetchByPart() {
        // TODO: 부위 별 루틴 분류
    }
    
    /// 루틴 상세 정보 네비게이션 용 함수
    func viewDetailedRoutine() {
        // TODO: 선택한 루틴 상세 정보 보기
    }
}
