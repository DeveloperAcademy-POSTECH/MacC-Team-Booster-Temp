//
//  RecordingRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 기록 중 운동 목록을 보기 위한 뷰
struct RecordingRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var routineVM: RoutineViewModel
    
    var body: some View {
        VStack {
            WorkoutList
            
            //            WorkoutStartButton
        }
        .onAppear {
            print(routineVM.RecordingRoutineViewRoutine)
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
            EditRecordingRoutineView()
        } label: {
            Text("편집")
                .font(.headline1())
                .foregroundColor(.green_main)
        }
    }
    
    var WorkoutList: some View {
        VStack {
            HStack {
                // TODO: .
                Text(routineVM.RecordingRoutineViewRoutine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                // TODO: .
                WorkoutListCell
                    .onTapGesture {
                        routineVM.isDetailedWorkoutSheetShow = true
                    }
            }
        }
        .padding(.horizontal)
    }
    
    var WorkoutListCell: some View {
        VStack{
            WorkoutSequenceCard(isCurrentWorkout: false, isFinish: true)
        }
    }
}

#Preview {
    RecordingRoutineView()
}
