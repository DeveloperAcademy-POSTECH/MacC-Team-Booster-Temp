//
//  AlternateWorkoutSheet.swift
//  beFLE
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct AlternateWorkoutSheet: View {
    let routineId: Int
    let exerciseId: Int
    @StateObject var vm = AlternativeWorkoutSheetViewModel()
    
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Spacer()
                NavitationTitle
                AlternativeWorkoutList
            }
            
            VStack{
                Spacer()
                LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                    .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                    .onTapGesture {
                        // Handle taps on the LinearGradient if needed
                    }
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                FinishButton
            }

        }
        .onAppear {
            vm.fetchWorkout(routineId: routineId, exerciseId: exerciseId)
        }
        .presentationDetents([.height(UIScreen.getHeight(479))])
    }
    
    var NavitationTitle: some View {
        VStack {
            HStack {
                Text("운동 대체")
                    .font(.title1())
                    .foregroundColor(.label_900)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Circle()
                        .foregroundColor(.gray_600)
                        .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                        .overlay {
                            Image(systemName: "multiply")
                                .foregroundColor(.label_700)
                                .font(.headline1())
                        }
                }
            }
            
            HStack {
                Text(vm.workout.name)
                    .font(.body())
                    .foregroundColor(.label_700)
                
                Spacer()
            }
        }
        .padding()
    }
    
    var AlternativeWorkoutList: some View {
        ScrollView {
            ForEach(0..<vm.workout.alternativeExercises.count, id: \.self) { index in
                Button {
                    vm.selection = index
                } label: {
                    AlternativeWorkoutCard(alternativeWorkout: vm.workout.alternativeExercises[index], isSelectedWorkout: vm.selection == index)
                }
            }
        }
    }
    
    var FinishButton: some View {
        Button {
            if vm.selection != -1 {
                vm.patchAlternate(routineId: routineId, exerciseId: vm.workout.exerciseId, alternativeExerciseId: vm.workout.alternativeExercises[vm.selection].alternativeExerciseId) {
                    editRoutineVM.workout = $0
                    editRoutineVM.fetchRoutine(routineId: routineId)
                    dismiss()
                }
            }
            else {
                dismiss()
            }
        } label: {
            Floating(size: .medium, color: .green_main) {
                Text("완료")
                    .font(.button1())
                    .foregroundColor(.gray_900)
            }
        }
        .padding(.bottom)
    }
}

struct AlternativeWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlternateWorkoutSheet(routineId: 1, exerciseId: 1)
        }
    }
}
