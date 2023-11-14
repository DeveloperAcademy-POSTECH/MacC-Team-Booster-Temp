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
            /// 구독 없을 때 보여줄 뷰
        case 0:
            InfluencerPreviewView()
            
            /// 구독 한 명일 때 보여줄 뷰
        case 1:
//            TodayStartView(routine:)
            EmptyView()
            /// 구독 여러 명일 때 보여줄 뷰
        default:
            MultiRoutineView()
        }
    }
}

#Preview {
    RoutineView()
}
