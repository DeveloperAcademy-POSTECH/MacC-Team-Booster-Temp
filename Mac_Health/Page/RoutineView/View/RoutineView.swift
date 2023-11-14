//
//  RoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

// TODO: vm 추가 - 인플루언서 구독 조회
struct RoutineView: View {
    @State var influencerIds: [Int] = []
    
    var body: some View {
        switch influencerIds.count {
        case 0: /// 구독 없을 때 보여줄 뷰
            InfluencerPreviewView()
        case 1: /// 구독 한 명일 때 보여줄 뷰
//            TodayStartView(routine:)
            EmptyView()
        default: /// 구독 여러 명일 때 보여줄 뷰
            MultiRoutineView()
        }
    }
}

#Preview {
    RoutineView()
}