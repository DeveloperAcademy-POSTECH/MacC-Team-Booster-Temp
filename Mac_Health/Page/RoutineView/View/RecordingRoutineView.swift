//
//  RecordingRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 기록 중 운동 목록을 보기 위한 뷰
struct RecordingRoutineView: View {
    @EnvironmentObject var routineVM: RoutineViewModel
    
    var body: some View {
        Text("RecordingRoutineView")
            .onAppear {
                print(routineVM.RecordingRoutineViewRoutine)
            }
    }
}

#Preview {
    RecordingRoutineView()
}
