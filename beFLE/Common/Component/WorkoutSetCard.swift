//
//  WorkoutSetCard.swift
//  beFLE
//
//  Created by 송재훈 on 2023/10/22.
//

import Combine
import SwiftUI

final class setChangeStream: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    @Published var weightInput: Int?
    @Published var debouncedWeight = 0
    @Published var repInput: Int?
    @Published var debouncedReps = 0
    
    init() {
        makeStream()
    }
    
    func makeStream() {
        $weightInput
            .debounce(for: RunLoop.SchedulerTimeType.Stride(1), scheduler: RunLoop.main)
            .sink { [weak self] input in
                if let input {
                    self?.debouncedWeight = input
                }
            }
            .store(in: &cancellables)
        
        $repInput
            .debounce(for: RunLoop.SchedulerTimeType.Stride(1), scheduler: RunLoop.main)
            .sink { [weak self] input in
                if let input {
                    self?.debouncedReps = input
                }
            }
            .store(in: &cancellables)
    }
}

struct WorkoutSetCard: View {
    let index: Int
    let routineId: Int
    let exerciseId: Int
    
    @EnvironmentObject var recordingWorkoutVM: RecordingWorkoutViewModel
    
    @StateObject var debouncedStream = setChangeStream()
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
                    TextField("자율", value: $debouncedStream.weightInput, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                        .onChange(of: debouncedStream.debouncedWeight) { weight in
                            recordingWorkoutVM.editWeight(routineId: routineId, exerciseId: exerciseId, setId: set.setId, weight: weight, reps: set.reps) { set in
                                self.set.weight = set.weight
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
                    TextField("자율", value: $debouncedStream.repInput, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                        .onChange(of: debouncedStream.debouncedReps) { reps in
                            recordingWorkoutVM.editReps(routineId: routineId, exerciseId: exerciseId, setId: set.setId, weight: set.weight, reps: reps) { set in
                                self.set.reps = set.reps
                            }
                        }
                }
            Text("회")
                .foregroundColor(.label_700)
            Spacer()
                .frame(width: UIScreen.getWidth(50))
            
            CheckButton(status: set.isDone ? .check : .empty)
        }
        .onAppear {
            debouncedStream.repInput = set.reps
            debouncedStream.weightInput = set.weight
        }
        .onChange(of: set.weight) { newValue in
            debouncedStream.weightInput = newValue
        }
        .onChange(of: set.reps) { newValue in
            debouncedStream.repInput = newValue
        }
        .font(.body())
        .padding(.horizontal)
        .padding(.horizontal, 10)
        .padding(.leading, 10)
        .padding(.vertical, 5)
    }
}
