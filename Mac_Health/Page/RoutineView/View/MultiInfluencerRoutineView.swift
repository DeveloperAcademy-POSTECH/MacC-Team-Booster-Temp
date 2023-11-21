//
//  MultiInfluencerRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

/// 인플루언서 다중 구독 뷰
struct MultiInfluencerRoutineView: View {
    @StateObject var vm = MultiInfluencerRoutineViewModel()
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                Image("appTitle")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                ScrollView {
                    if !vm.routines.routine.isEmpty {
                        ForEach(vm.routines.routine, id: \.self) { routine in
                            NavigationLink {
//                                TodayStartView(routine: routine)
                            } label: {
                                SubscribedInfluencerCard(routine: routine)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MultiInfluencerRoutineView()
}
