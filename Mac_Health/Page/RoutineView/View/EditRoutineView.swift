//
//  EditRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 시작 했을 때 운동 시작하기 전 운동 목록 편집하는 뷰
/// - Parameters:
///  - routineId: 수정할 루틴에 대한 id
struct EditRoutineView: View {
    let routineId: Int
    @StateObject var vm = EditRoutineViewModel()
    
    var body: some View {
        Text("EditRoutineView")
            .onAppear {
                vm.fetchRoutine(routineId: routineId)
            }
    }
}

#Preview {
    EditRoutineView(routineId: 1)
}
