//
//  WorkoutSetCard.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct WorkoutSetCard: View {
    let index: Int
    let routineId: Int
    let exerciseId: Int
    
    @EnvironmentObject var recordingWorkoutVM: RecordingWorkoutViewModel
    
    @Binding var set: ExerciseSet
    
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            Text("\(index)")
                .foregroundColor(.label_900)
            Spacer()
            
            // TODO: 시저 - 텍스트필드 선택 시 플로팅 버튼 사라짐
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
                        .onChange(of: set.weight) { weight in
                            // TODO: debounce
                            // TODO: 포커스 처리
                            if weight != nil {
                                recordingWorkoutVM.editSet(index: index - 1, routineId: routineId, exerciseId: exerciseId, setId: set.setId, weight: weight!, reps: set.reps) {
                                    set.weight = $0.weight
                                }
                            }
                        }
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
                        .onChange(of: set.reps) { reps in
                            // TODO: debounce
                            // TODO: 포커스 처리
                            recordingWorkoutVM.editSet(index: index - 1, routineId: routineId, exerciseId: exerciseId, setId: set.setId, weight: set.weight ?? 0, reps: reps) {
                                set.reps = $0.reps
                            }
                        }
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
//
//struct WorkoutSetCard_Previews:
//    PreviewProvider {
//    static var previews: some View {
//        WorkoutSetCard(index: 1, set: .constant(ExerciseSet(setId: 1, reps: 5, isDone: false)), isFocused: FocusState().projectedValue)
//    }
//}
