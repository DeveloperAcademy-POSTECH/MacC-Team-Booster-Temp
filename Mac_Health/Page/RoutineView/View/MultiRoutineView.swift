//
//  MultiRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

struct MultiRoutineView: View {
    @StateObject var vm = MultiRoutineViewModel()
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                Image("appTitle")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 20)
                ScrollView {
                    if !vm.routines.routines.isEmpty {
                        ForEach(0..<vm.routines.routines.count, id: \.self) {
                            SubscribedInfluencerCard(routine: vm.routines.routines[$0])
                                .padding(.bottom, 10)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MultiRoutineView()
}
