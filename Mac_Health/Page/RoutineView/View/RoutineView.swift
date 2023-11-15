//
//  RoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 루틴 탭 최상위 뷰
struct RoutineView: View {
    @StateObject var vm = RoutineViewModel()
    
    var body: some View {
        switch vm.routines.routines.count {
        case 0: /// 구독 없을 때 보여줄 뷰
            InfluencerPreviewView()
        case 1: /// 구독 한 명일 때 보여줄 뷰
            SingleInfluencerRoutineView(routine: $vm.routines.routines[0])
                .environmentObject(vm)
        default: /// 구독 여러 명일 때 보여줄 뷰
            MultiInfluencerRoutineView()
        }
    }
}

#Preview {
    RoutineView()
}
