//
//  RoutineView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 루틴 탭 최상위 뷰
struct RoutineView: View {
    @StateObject var vm = RoutineViewModel()
    
    var body: some View {
        ZStack {
            switch vm.todayRoutines.routine.count {
            case 0:
                InfluencerPreviewView()
            default:
                SingleInfluencerRoutineView(routine: $vm.todayRoutines.routine[0])
            }
        }
        .onAppear {
            vm.fetch()
        }
    }
}

#Preview {
    RoutineView()
}
