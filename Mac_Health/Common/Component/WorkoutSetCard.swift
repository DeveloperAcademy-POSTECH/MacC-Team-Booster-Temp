//
//  WorkoutSetCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct WorkoutSetCard: View {
    @Binding var workoutSet: WorkoutSetModel
    
    var body: some View {
        HStack {
            Text("\(workoutSet.index)")
                .foregroundColor(.label_900)
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("자율", value: $workoutSet.kg, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_500)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                }
            Text("kg")
                .foregroundColor(.label_700)
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("", value: $workoutSet.repetition, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                }
            Text("회")
                .foregroundColor(.label_700)
            Spacer()
            
            if workoutSet.isFinish {
                CheckButton()
            }
            else {
                EmptyCheckButton()
            }
        }
        .font(.body())
        .padding(.horizontal)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct WorkoutSetCard_Previews:
    PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                WorkoutSetCard(workoutSet: .constant(WorkoutSetModel(index: 1, kg: 5, repetition: 5, isFinish: true)))
                WorkoutSetCard(workoutSet: .constant(WorkoutSetModel(index: 2, kg: 5, repetition: 5, isFinish: true)))
                WorkoutSetCard(workoutSet: .constant(WorkoutSetModel(index: 3, kg: 5, repetition: 5, isFinish: false)))
            }
        }
    }
}
