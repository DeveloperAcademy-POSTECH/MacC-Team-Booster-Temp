//
//  EditRecordingRoutineView.swift
//  beFLE
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

struct EditRecordingRoutineView: View {
    let routineId: Int
    
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
    
    
    @Environment(\.dismiss) var dismiss: DismissAction
    var burnedKCalories: Int
    var body: some View {
        VStack {
            WorkoutList
//            WorkoutStartButton
        }
        .navigationTitle("운동 루틴 편집")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $editRoutineVM.isDetailedWorkoutSheetShow) {
            DetailedWorkoutSheet(routineId: routineId, exerciseId: editRoutineVM.routine.exercises[editRoutineVM.selectedIndex].id)
        }
        .confirmationDialog(editRoutineVM.routine.exercises.isEmpty ? "" : editRoutineVM.routine.exercises[editRoutineVM.selectedIndex].name , isPresented: $editRoutineVM.isEditWorkoutActionShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $editRoutineVM.isAlternateWorkoutSheetShow) {
            AlternateWorkoutSheet(routineId: routineId, exerciseId: editRoutineVM.routine.exercises[editRoutineVM.selectedIndex].id)
                .environmentObject(editRoutineVM)
                .onDisappear{
                    editRoutineVM.fetchRoutine(routineId: routineId)
                }
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $editRoutineVM.isDeleteWorkoutAlertShow) {
            DeleteAlert
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline2())
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
                    WorkoutListCell(index: index)
                }
            }
        }
        .padding()
    }
    
    func WorkoutListCell(index: Int) -> some View {
        HStack {
            Button {
                editRoutineVM.selectedIndex = index
                editRoutineVM.isDetailedWorkoutSheetShow = true
            } label: {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.fill_1)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                        .overlay {
                            AsyncImage(url: URL(string: editRoutineVM.routine.exercises[index].exerciseImageUrl)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.label_400)
                                    .padding()
                            }
                        }
                    
                    VStack(alignment: .leading) {
                        Text(editRoutineVM.routine.exercises[index].name)
                            .foregroundColor(.label_900)
                            .font(.headline1())
                            .multilineTextAlignment(.leading)
                        HStack {
                            Text("\(editRoutineVM.routine.exercises[index].numberOfSet)세트")
                                .foregroundColor(.label_700)
                                .font(.body2())
                            Text("|")
                                .foregroundColor(.label_400)
                                .font(.body2())
                            Text("\(editRoutineVM.routine.exercises[index].recommendReps)회")
                                .foregroundColor(.label_700)
                                .font(.body2())
                        }
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Button {
                editRoutineVM.selectedIndex = index
                editRoutineVM.isEditWorkoutActionShow = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.label_700)
            }
        }
        .padding(.vertical, 4)
    }
    
    var WorkoutStartButton: some View {
        NavigationLink {
            RecordingWorkoutView(routineId: routineId, exerciseId: editRoutineVM.routine.exercises.isEmpty ? 0 : editRoutineVM.routine.exercises[editRoutineVM.currentWorkoutIndex].id, burnedKCalories: burnedKCalories)
                .environmentObject(editRoutineVM)
        } label: {
            FloatingButton(backgroundColor: .green_main) {
                Text("시작")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
        }
    }
    
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            editRoutineVM.isAlternateWorkoutSheetShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            editRoutineVM.isDeleteWorkoutAlertShow = true
        } label: {
            Text("삭제")
        }
        
        Button(role: .cancel) {

        } label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var DeleteAlert: some View {
        Button("취소") {

        }
        Button("삭제") {
            editRoutineVM.deleteWorkout(routineId: routineId, exerciseId: editRoutineVM.workout.exerciseId)
        }
    }
}

//#Preview {
//    EditRecordingRoutineView(routineId: 1)
//}
