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
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            VStack {
                Spacer()
                NavitationTitle
                AlternativeWorkoutList
            }
            Gradient
            FinishButton
        }
        .onAppear {
            vm.fetchWorkout(routineId: routineId, exerciseId: exerciseId)
        }
        .presentationDetents([.height(UIScreen.getHeight(479))])
    }
}

/// 네비게이션 타이틀
extension AlternateWorkoutSheet {
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
}

/// 그라디언트
extension AlternateWorkoutSheet {
    var Gradient: some View {
        VStack {
            Spacer()
            LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                .onTapGesture {
                    // Handle taps on the LinearGradient if needed
                }
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
}

/// 대체 운동 리스트
extension AlternateWorkoutSheet {
    var AlternativeWorkoutList: some View {
        ScrollView {
            ForEach(Array(vm.workout.alternativeExercises.enumerated()), id: \.element) { pair in
                Button {
                    vm.selection = pair.offset
                } label: {
                    AlternativeWorkoutCard(alternativeWorkout: pair.element, isSelectedWorkout: vm.selection == pair.offset)
                }
            }
        }
    }
}

/// 버튼
extension AlternateWorkoutSheet {
    var FinishButton: some View {
        VStack {
            Spacer()
            Button {
                if vm.selection != -1 {
                    vm.patchAlternate(routineId: routineId, exerciseId: exerciseId, alternativeExerciseId: vm.workout.alternativeExercises[vm.selection].alternativeExerciseId) {
                        dismiss()
                    }
                }
                else {
                    dismiss()
                }
            } label: {
                FloatingButton(size: .medium, color: .green_main) {
                    Text("완료")
                        .font(.button1())
                        .foregroundColor(.gray_900)
                }
            }
            .padding(.bottom)
        }
    }
}

struct AlternativeWorkoutSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AlternateWorkoutSheet(routineId: 1, exerciseId: 1)
        }
    }
}
