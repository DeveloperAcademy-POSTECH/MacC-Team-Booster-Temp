//
//  SingleInfluencerRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 인플루언서 단일 구독 뷰
struct SingleInfluencerRoutineView: View {
    @Binding var routine: InfluencerRoutine
    @StateObject var vm = SingleInfluencerRoutineViewModel()
    
    var body: some View {
        ZStack {
            Text("SingleInfluencerRoutineView")
        }
    }
}

#Preview {
    SingleInfluencerRoutineView(routine: .constant(InfluencerRoutine(routineId: 1, part: "", date: "", numberOfExercise: 5, burnedKCalories: 5, requiredMinutes: 5, comment: "", name: "", routineName: "", influencerProfileImageUrl: "", influencerId: 1)))
}
