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
            Button {
                print(vm.todayRoutines)
            } label: {
                Text("asdasd")
            }
//            switch vm.todayRoutines.routine.count {
//            case 0: /// 구독 없을 때 보여줄 뷰
//                InfluencerPreviewView()
//            default: /// 구독 한 명일 때 보여줄 뷰
//                SingleInfluencerRoutineView(routine: $vm.todayRoutines.routine[0])
//            }
        }
        .onAppear {
//            vm.fetchTodayRoutines()
        }
    }
}

#Preview {
    RoutineView()
}
