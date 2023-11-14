//
//  MultiInfluencerRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

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
                    if !vm.routines.routines.isEmpty {
                        ForEach(vm.routines.routines, id: \.self) { routine in
                            NavigationLink {
                                TodayStartView(routine: routine)
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
