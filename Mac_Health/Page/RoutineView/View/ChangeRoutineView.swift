//
//  ChangeRoutineView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

enum WorkoutType: String, CaseIterable {
    case 전체, 등, 가슴, 이두, 삼두, 하체, 후면사슬, 복근
}

struct ChangeRoutineView: View {
    let influencerId: Int
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject var vm = ChangeRoutineViewModel()
    
    var body: some View {
        VStack {
            SortingSlider
            ZStack {
                //선택된 selection 들이 포함된 운동
                Workouts
                ///if logInt ? 0 : 3
                    .blur(radius: 0)
                //                    Blind
            }
        }
        .onAppear {
            vm.fetchRoutines(influencerId: influencerId)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
            
            ToolbarItem(placement: .principal) {
                NavigationTitle
            }
        }
    }
    
    var NavigationTitle: some View {
        Text("전체 루틴")
            .font(.headline1())
            .foregroundColor(.label_900)
    }
    
    var Blind: some View {
        VStack(spacing: UIScreen.getHeight(28)) {
            Text("구독을 통해\n매일의 루틴 정보를 확인할수 있어요")
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .font(.title2())
                .foregroundColor(.label_900)
            
            Button {
                // TODO: 버튼 기능
            } label: {
                Capsule()
                    .foregroundColor(.green_main)
                    .frame(width: UIScreen.getWidth(180), height: UIScreen.getHeight(60))
                    .overlay {
                        Text("둘러보기")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                    }
            }
        }
    }
    
    var Workouts: some View {
        ScrollView {
            ForEach(vm.routines.routines, id: \.self) { routine in
                NavigationLink {
                    SelectedRoutineView(routineId: routine.routineId)
                        .navigationBarTitle("\(vm.dateFormat(from: routine.date))", displayMode: .inline)
                } label: {
                    TodayWorkoutCell(routine: routine)
                        .padding(.vertical, 8)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func TodayWorkoutCell(routine: Routine) -> some View {
        HStack(spacing: UIScreen.getWidth(16)) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(vm.dateCompare(from: routine.date) ? .label_900 : .fill_2)
                .frame(width: UIScreen.getWidth(40), height: UIScreen.getHeight(40))
                .overlay {
                    Text("\(vm.dayFormat(from: routine.date))")
                        .font(.headline1())
                        .foregroundColor(vm.dateCompare(from: routine.date) ? .gray_900 : .label_900)
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
    
    var SortingSlider: some View {
        ScrollView(.horizontal) {
            HStack(spacing: UIScreen.getWidth(6)) {
                ForEach(WorkoutType.allCases, id: \.self) { type in
                    Button {
                        vm.selection = type.rawValue
                    } label: {
                        if type.rawValue == vm.selection {
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
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.body())
        }
    }
}

#Preview {
    NavigationStack{
        ChangeRoutineView(influencerId: 1)
    }
}
