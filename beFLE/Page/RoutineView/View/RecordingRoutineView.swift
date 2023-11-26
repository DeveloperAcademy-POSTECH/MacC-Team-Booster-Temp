//
//  RecordingRoutineView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 기록 중 운동 목록을 보기 위한 뷰
struct RecordingRoutineView: View {
    @EnvironmentObject var workoutVM: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            WorkoutList
        }
        .navigationTitle("운동 목록")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                EditButton
            }
        }
        .navigationBarBackButtonHidden()
    }
}

/// 네비게이션 타이틀
extension RecordingRoutineView {
    var BackButton: some View {
        Button {
            workoutVM.changeViewStatus(.recordingWorkoutView)
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline2())
                .foregroundColor(.label_700)
        }
    }
    
    var EditButton: some View {
        Button {
            workoutVM.changeViewStatus(.editRecordingRoutineView)
        } label: {
            Text("편집")
                .font(.headline1())
                .foregroundColor(.green_main)
        }
    }
}

/// 운동 정보
extension RecordingRoutineView {
    var WorkoutList: some View {
        VStack {
            HStack {
                Text(workoutVM.routine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                ForEach(Array(workoutVM.routine.exercises.enumerated()), id: \.element) { pair in
                    Button {
                        workoutVM.currentWorkoutIndex = pair.offset
                        workoutVM.fetchExerciseId(exerciseId: pair.element.id)
                    } label: {
                        WorkoutCell(index: pair.offset)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding([.top, .horizontal])
    }
    
    func WorkoutCell(index: Int) -> some View {
        HStack(spacing: 8){
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(.fill_1)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .overlay {
                    AsyncImage(url: URL(string: workoutVM.routine.exercises[index].exerciseImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        LottieView()
                            .padding(5)
                    }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if workoutVM.routine.exercises[index].id == workoutVM.exercise.exerciseId {
                        Image(systemName: "flame.fill")
                            .font(.headline1())
                            .foregroundColor(.green_main)
                    }
                    Text(workoutVM.routine.exercises[index].name)
                        .font(.headline1())
                        .foregroundColor(workoutVM.routine.exercises[index].id == workoutVM.exercise.exerciseId ? .green_main : .label_900)
                        .multilineTextAlignment(.leading)
                        .allowsTightening(true)
                    Spacer()
                }
                HStack(spacing: 6) {
                    Text("\(workoutVM.routine.exercises[index].numberOfSet)세트")
                        .font(.body2())
                        .foregroundColor(.label_700)
                    Text("|")
                        .font(.body2())
                        .foregroundColor(.label_400)
                        .scaleEffect(0.8)
                    Text("\(workoutVM.routine.exercises[index].recommendReps)회")
                        .font(.body2())
                        .foregroundColor(.label_700)
                }
            }
            .padding(.horizontal)
            Spacer()
            
            if workoutVM.routine.exercises[index].isDone {
                CheckButton()
            }
            else {
                EmptyCheckButton()
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(64))
        .padding(.vertical, 4)
    }
}

//#Preview {
//    RecordingRoutineView(routineId: 1)
//}
