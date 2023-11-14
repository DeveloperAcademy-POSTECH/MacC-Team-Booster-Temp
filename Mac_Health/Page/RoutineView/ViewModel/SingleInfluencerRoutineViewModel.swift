//
//  SingleInfluencerRoutineViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class SingleInfluencerRoutineViewModel: ObservableObject {
    /// 뷰에 보여질 운동
    @Published var routine = ""
    
    /// 오늘 운동 조회
    func patchRoutine(influencerId: Int) {
        // TODO: 오늘 날짜, 인플루언서 아이디로 서버에 데이터 요청
        let date = Date()
    }
    
    /// 운동 시작 네비게이션 용
    func startWorkout(routine: String) {
        // TODO: 네비게이션으로 데이터 전달, routine 모델 변경하기
    }
    
    /// 달력 버튼 네비게이션 용 전체 운동 보기
    func viewWholeWorkout(influencerId: Int) {
        // TODO: 네비게이션으로 인플루언서 아이디 전달
    }
}
