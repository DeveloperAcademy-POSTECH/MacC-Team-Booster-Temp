//
//  WorkoutSetCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct WorkoutSetCard: View {
    let index: Int
    @Binding var set: ExerciseSet
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            Text("\(index)")
                .foregroundColor(.label_900)
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("자율", value: $set.weight, format: .number)
                        .focused(isFocused)
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
                    TextField("", value: $set.reps, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                }
            Text("회")
                .foregroundColor(.label_700)
            Spacer()
            
            if set.isDone {
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
        WorkoutSetCard(index: 1, set: .constant(ExerciseSet(setId: 1, reps: 5, isDone: false)))
    }
}
