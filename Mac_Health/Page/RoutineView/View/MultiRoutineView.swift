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
        VStack {
            Image("appTitle")
                .resizable()
                .scaledToFit()
                .padding(.bottom, 20)
            ScrollView {
                if !vm.routines.routines.isEmpty {
                    ForEach(vm.routines.routines, id: \.self) { routine in
                        SubscribedInfluencerCard(routine: routine)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

#Preview {
    MultiRoutineView()
}
