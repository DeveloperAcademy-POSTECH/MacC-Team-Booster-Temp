//
//  SelectedRoutineView.swift
//  beFLE
//
//  Created by 정회승 on 11/3/23.
//

import SwiftUI

struct SelectedRoutineView: View {
    let routineId: Int
    var burnedKCalories: Int
    @StateObject var vm = SelectedRoutineViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    SpecificInformation
                }
                .padding(.vertical, 20)
                Divider()
                    .foregroundColor(.fill_1)
                    .padding(.horizontal, 20)
                WorkoutRoutine
                
                // TODO: empty floating button 변경
                EmptyFloatingButton
                    .padding()
            }
            VStack {
                Spacer()
                NavigationLink {
                    EditRoutineView(routineId: routineId)
                } label: {
                    FloatingButton(backgroundColor: .green_main) {
                        Text("운동 시작")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                    }
                }
                .padding()
            }
        }
        .onAppear {
            vm.fetchRoutine(routineId: routineId)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }
    }
    
    var SpecificInformation: some View {
        VStack {
            Information(systemName: "figure.arms.open", description: vm.routine.part)
            Information(systemName: "square.stack.fill", description: "\(vm.routine.numberOfExercise)개")
            Information(systemName: "clock.fill", description: "\(vm.routine.requiredMinutes)분")
            Information(systemName: "flame.circle.fill", description: "\(vm.routine.burnedKCalories)kcal")
        }
    }
    
    var EmptyFloatingButton: some View {
        FloatingButton(backgroundColor: .clear) { }
    }
    
    func Information(systemName: String, description: String) -> some View {
        HStack {
            Image(systemName: systemName)
                .font(.body())
                .foregroundColor(.label_700)
                .padding(.leading, 15)
            Text(description)
                .font(.body())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding(5)
    }
    
    var WorkoutRoutine: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    Text(vm.routine.part)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                    Spacer()
                }
                .frame(width: UIScreen.getWidth(350))
                .padding(.top ,UIScreen.getHeight(20))
                
                ForEach(vm.routine.exercises, id: \.self) { exercise in
                    WorkoutCell(exercise: exercise)
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
                .font(.headline2())
        }
    }
}

//#Preview {
//    NavigationStack {
//        SelectedRoutineView(routineId: 1)
//    }
//}
