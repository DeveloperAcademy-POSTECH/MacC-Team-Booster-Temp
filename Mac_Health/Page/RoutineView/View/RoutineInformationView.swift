//
//  RoutineInformationView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 루틴 정보를 확인하는 뷰
/// - Parameters:
///  - routineId: 정보를 확인할 루틴 id
struct RoutineInformationView: View {
    let routineId: Int
    @StateObject var vm = RoutineInformationViewModel()
    
    var body: some View {
        Text("RoutineInformationView")
    }
}

#Preview {
    RoutineInformationView(routineId: 1)
}
