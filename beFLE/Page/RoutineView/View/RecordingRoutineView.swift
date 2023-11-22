//
//  RecordingRoutineView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 기록 중 운동 목록을 보기 위한 뷰
struct RecordingRoutineView: View {
    let routineId: Int
    var burnedKCalories: Int
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
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
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline2())
                .foregroundColor(.label_700)
        }
    }
    
    var EditButton: some View {
        NavigationLink {
            EditRecordingRoutineView(routineId: routineId, burnedKCalories: burnedKCalories)
                .environmentObject(editRoutineVM)
        } label: {
            Text("편집")
                .font(.headline1())
                .foregroundColor(.green_main)
        }
    }
    
    var WorkoutList: some View {
        VStack {
            HStack {
                Text(editRoutineVM.routine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                ForEach(0..<editRoutineVM.routine.exercises.count, id: \.self) { index in
                    Button {
                        editRoutineVM.currentWorkoutIndex = index
                        editRoutineVM.fetchWorkout(routineId: routineId, exerciseId: editRoutineVM.routine.exercises[index].id)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            // 여기에 실행할 작업 추가
                                            dismiss()
                                        }
                    } label: {
                        WorkoutCell(index: index)
                    }
                }
            }
        }
        .padding([.top, .horizontal])
    }
    
    func WorkoutCell(index: Int) -> some View {
        HStack(spacing: 8){
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.fill_1)
                .overlay {
                    //TODO:  대체 운동 이미지 로딩
                    Image("CloseGripLatPullDown")
                        .resizable()
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if editRoutineVM.routine.exercises[index].id == editRoutineVM.workout.exerciseId {
                        Image(systemName: "flame.fill")
                            .font(.headline1())
                            .foregroundColor(.green_main)
                    }
                    Text(editRoutineVM.routine.exercises[index].name)
                        .font(.headline1())
                        .foregroundColor(editRoutineVM.routine.exercises[index].id == editRoutineVM.workout.exerciseId ? .green_main : .label_900)
                    Spacer()
                }
                HStack(spacing: 6) {
                    Text("\(editRoutineVM.routine.exercises[index].numberOfSet)세트")
                        .font(.body2())
                        .foregroundColor(.label_700)
                    Text("|")
                        .font(.body2())
                        .foregroundColor(.label_400)
                        .scaleEffect(0.8)
                    Text("\(editRoutineVM.routine.exercises[index].recommendReps)회")
                        .font(.body2())
                        .foregroundColor(.label_700)
                }
            }
            .padding(.horizontal)
            Spacer()
            
            if editRoutineVM.routine.exercises[index].isDone {
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
