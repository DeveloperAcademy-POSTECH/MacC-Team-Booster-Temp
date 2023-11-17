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
                Text("TESER")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                // TODO: .
                WorkoutListCell
                    .onTapGesture {
//                        routineVM.isDetailedWorkoutSheetShow = true
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
