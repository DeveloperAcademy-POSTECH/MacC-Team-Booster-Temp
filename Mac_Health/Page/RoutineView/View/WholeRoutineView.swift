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
///  - Parameters:
///   - influencerId: 조회할 인플루언서의 id
struct WholeRoutineView: View {
    let influencerId: Int
    @StateObject var vm = WholeRoutineViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        VStack{
            NavigationLink{
                if !vm.routines.routines.isEmpty {
                    RoutineInformationView(routineId: vm.routines.routines[0].routineId)
                    //TODO: "2023-10-24"식 "10월 24일"식으로
                        .navigationTitle(vm.routines.routines[0].date)
                }
            } label: {
                Text("WholeRoutineView")
            }
        }
        .navigationTitle("전체루틴")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }
        .onAppear {
            vm.fetchRoutines(influencerId: influencerId)
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_900)
                .font(.body())
        }
    }
}

#Preview {
    WholeRoutineView(influencerId: 1)
}
