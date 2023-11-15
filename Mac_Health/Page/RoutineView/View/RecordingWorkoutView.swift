//
//  RecordingWorkoutView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 시작 했을 때 기록하기 위한 뷰
/// - Parameters:
///  - routineId: 정보를 조회할 루틴의 id
///  - exerciseId: 정보를 조회할 루틴의 운동 id
struct RecordingWorkoutView: View {
    let routineId: Int
    let exerciseId: Int
    @StateObject var vm = RecordingWorkoutViewModel()
    
    var body: some View {
        Text("RecordingWorkoutView")
    }
}

#Preview {
    RecordingWorkoutView(routineId: 2, exerciseId: 7)
}
