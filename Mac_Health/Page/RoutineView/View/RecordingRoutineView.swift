//
//  RecordingRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 기록 중 운동 목록을 보기 위한 뷰
struct RecordingRoutineView: View {
    let routineId: Int
        
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
                .font(.headline1())
                .foregroundColor(.label_700)
        }
    }
    
    var EditButton: some View {
        NavigationLink {
            EditRecordingRoutineView(routineId: routineId)
                .environmentObject(editRoutineVM)
        } label: {
            Text("편집")
                .font(.headline1())
                .foregroundColor(.green_main)
        }
    }
    
    //TODO: 해당 운동 누르면 진행 중 운동에서 해당 운동으로 변경 - MORO
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
                    WorkoutCell(index: index)
                }
            }
        }
        .padding()
    }
    
    func WorkoutCell(index: Int) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.fill_1)
                .overlay {
                    Image("CloseGripLatPullDown")
                        .resizable()
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                }
            Spacer()
            Spacer()
            
            VStack(alignment: .leading) {
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
                HStack {
                    Text("\(editRoutineVM.routine.exercises[index].numberOfSet)세트")
                    Text("|")
                    Text("\(editRoutineVM.routine.exercises[index].recommendReps)회")
                }
                .font(.body2())
                .foregroundColor(.label_700)
            }
            
            Spacer()
            Spacer()
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

#Preview {
    RecordingRoutineView(routineId: 1)
}
