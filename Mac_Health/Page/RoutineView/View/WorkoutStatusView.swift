//
//  WorkoutStatus.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/5/23.
//

import SwiftUI

struct WorkoutStatusView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isDetailedWorkoutShow = false
    @State var isConfirmationDialogShow = false
    @State var isAlternativeWorkoutShow = false
    @State var isDeleteAlertShow = false
    
    let workoutName = "클로즈 그립 랫 풀 다운"
    
    var body: some View {
        VStack {
            WorkoutList
            
            //            WorkoutStartButton
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
        .sheet(isPresented: $isDetailedWorkoutShow) {
            DetailedWorkoutSheet()
        }
        .confirmationDialog(workoutName, isPresented: $isConfirmationDialogShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $isAlternativeWorkoutShow) {
            AlternativeWorkoutSheet()
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $isDeleteAlertShow) {
            DeleteAlert
        }
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
            WorkoutStatusEditView()
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
                Text("등")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                // TODO: .
                WorkoutListCell
                    .onTapGesture {
                        isDetailedWorkoutShow = true
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
    
    //    var WorkoutStartButton: some View {
    //        Button {
    //            // TODO: .
    //        } label: {
    //            FloatingButton(backgroundColor: .green_main) {
    //                Text("시작")
    //                    .foregroundColor(.gray_900)
    //                    .font(.button1())
    //            }
    //        }
    //    }
    
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            // TODO: .
            isAlternativeWorkoutShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            // TODO: .
            isDeleteAlertShow = true
        } label: {
            Text("삭제")
        }
        
        Button(role: .cancel) {
            // TODO: .
        } label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var DeleteAlert: some View {
        Button("취소") {
            // TODO: .
        }
        Button("삭제") {
            // TODO: .
        }
    }
}

struct WorkoutStatus_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkoutStatusView()
        }
    }
}
