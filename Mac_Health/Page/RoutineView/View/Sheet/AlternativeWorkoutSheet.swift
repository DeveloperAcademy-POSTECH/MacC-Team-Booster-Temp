//
//  AlternativeWorkoutSheet.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct AlternativeWorkoutSheet: View {
    let baseExercise: String
    let baseRoutineId: Int
    let baseExerciseId: Int
    let alternativeExercise: [AlternativeExercise]
    
    @StateObject var vm = AlternativeWorkoutSheetViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Spacer()
                NavitationTitle
                AlternativeWorkoutList
                
                FinishButton
            }
        }
        .presentationDetents([.height(UIScreen.getHeight(519))])
    }
    
    var NavitationTitle: some View {
        VStack {
            HStack {
                Text("운동 대체하기")
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
                Text(baseExercise)
                    .font(.body())
                    .foregroundColor(.label_700)
                
                Spacer()
            }
        }
        .padding()
    }
    
    var AlternativeWorkoutList: some View {
        ScrollView {
            ForEach(0..<alternativeExercise.count, id: \.self) { index in
                Button {
                    vm.selection = index
                } label: {
                    AlternativeWorkoutCard(alternativeWorkout: alternativeExercise[index], isSelectedWorkout: vm.selection == index)
                }
            }
        }
    }
    
    var FinishButton: some View {
        Button {
            if vm.selection != -1 {
                vm.patchAlternate(routineId: baseRoutineId, exerciseId: baseExerciseId, alternativeExerciseId: alternativeExercise[vm.selection].alternativeExerciseId)
            }
        } label: {
            FloatingButton(backgroundColor: .green_main) {
                Text("완료")
                    .font(.button1())
                    .foregroundColor(.gray_900)
            }
        }
    }
}

struct AlternativeWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlternativeWorkoutSheet(baseExercise: "클로즈 그립 랫 풀 다운", baseRoutineId: 1, baseExerciseId: 1, alternativeExercise: [])
        }
    }
}
