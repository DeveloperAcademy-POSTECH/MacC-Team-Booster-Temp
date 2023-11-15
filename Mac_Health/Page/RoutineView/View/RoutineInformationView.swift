//
//  RoutineInformationView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 루틴 정보를 확인하는 뷰
/// - Parameters:
///  - routine: 정보를 확인할 루틴
struct RoutineInformationView: View {
    @Binding var routine: Routine
    @StateObject var vm = RoutineInformationViewModel()
    
    var body: some View {
        Text("RoutineInformationView")
    }
}

#Preview {
    RoutineInformationView(routine: .constant(Routine(part: "", date: "", isDone: false, routineId: 1)))
}
