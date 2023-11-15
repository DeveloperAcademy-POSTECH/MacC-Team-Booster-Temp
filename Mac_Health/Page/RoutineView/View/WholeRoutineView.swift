//
//  WholeRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

enum WorkoutPart: String, CaseIterable {
    case 전체, 등, 가슴, 이두, 삼두, 하체, 후면사슬, 복근
}

/// 인플루언서 개인의 전체 루틴 뷰
///  - Parameter : influencerId를 전달 받아서 해당 인플루언서의 전체 루틴을 조회
struct WholeRoutineView: View {
    let influencerId: Int
    @StateObject var vm = WholeRoutineViewModel()
    
    init(influencerId: Int) {
        self.influencerId = influencerId
        vm.fetchRoutines(influencerId: influencerId)
    }
    
    var body: some View {
        Text("WholeRoutineView")
    }
}

#Preview {
    WholeRoutineView(influencerId: 1)
}
