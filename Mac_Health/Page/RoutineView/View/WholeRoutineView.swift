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
    
    // TODO: 컨벤션 맞춰 컴포넌트 명 변경
    var body: some View {
        VStack {
            SortingSlider
            Workouts
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
    
    var SortingSlider: some View {
        ScrollView(.horizontal) {
            HStack(spacing: UIScreen.getWidth(6)) {
                ForEach(WorkoutPart.allCases, id: \.self) { type in
                    Button {
                        vm.selectedPart = type.rawValue
                    } label: {
                        if vm.selectedPart == type.rawValue  {
                            SelectedCapsule(text: type.rawValue)
                        }
                        else {
                            NotSelectedCapsule(text: type.rawValue)
                        }
                    }
                }
                .frame(height: UIScreen.getHeight(34))
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    
    @ViewBuilder
    func NotSelectedCapsule(text: String) -> some View {
        Capsule()
            .strokeBorder()
            .foregroundColor(.label_400)
            .frame(minWidth: UIScreen.getWidth(54), idealHeight: UIScreen.getHeight(34))
            .overlay {
                Text(text)
                    .foregroundColor(.label_900)
                    .font(.button2())
            }
    }
    
    @ViewBuilder
    func SelectedCapsule(text: String) -> some View {
        Capsule()
            .foregroundColor(.green_main)
            .frame(minWidth: UIScreen.getWidth(54), idealHeight: UIScreen.getHeight(34))
            .overlay {
                Text(text)
                    .foregroundColor(.gray_900)
                    .font(.button2())
            }
    }
    
    var Workouts: some View {
        ScrollView {
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
                            RoutineInformationView(routineId: some.routineId)
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
