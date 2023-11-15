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
            Workouts
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
    
    var Workouts: some View {
        ScrollView {
            // TODO: 월 별 데이터
            
            ForEach(Array(vm.routinesByMonth.keys), id: \.self) { key in
                VStack {
                    HStack {
                        Text("\(key)월")
                            .foregroundColor(.label_900)
                            .font(.headline1())
                        Spacer()
                    }
                    ForEach(vm.routinesByMonth[key]!, id: \.self) { some in
                        NavigationLink {
                            SelectedRoutineView(routineId: some.routineId)
                                .navigationBarTitle("\(vm.formatForDate(from: some.date))", displayMode: .inline)
                        } label: {
                            TodayWorkoutCell(routine: some)
                                .padding(.vertical, 8)
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    func TodayWorkoutCell(routine: Routine) -> some View {
        HStack(spacing: UIScreen.getWidth(16)) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(vm.compareToday(from: routine.date) ? .label_900 : .fill_2)
                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                .overlay {
                    Text("\(vm.formatForDay(from: routine.date))")
                        .font(.headline1())
                        .foregroundColor(vm.compareToday(from: routine.date) ? .gray_900 : .label_900)
                }
            Text("\(routine.part)")
                .font(.headline1())
                .foregroundColor(.label_900)
            
            Spacer()
            
            if routine.isDone {
                Circle()
                    .frame(width: UIScreen.getWidth(36))
                    .foregroundColor(.green_10)
                    .overlay {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green_main)
                            .font(.body2())
                    }
            }
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
