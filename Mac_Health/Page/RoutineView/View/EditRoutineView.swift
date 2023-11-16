//
//  EditRoutineView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 시작 했을 때 운동 시작하기 전 운동 목록 편집하는 뷰
/// - Parameters:
///  - routineId: 수정할 루틴에 대한 id
struct EditRoutineView: View {
    let routineId: Int
    
    @StateObject var vm = EditRoutineViewModel()
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        VStack {
            WorkoutList
            
            WorkoutStartButton
        }
        .onAppear {
            vm.fetchRoutine(routineId: routineId)
        }
        .navigationTitle("운동 루틴 편집")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $vm.isDetailedWorkoutSheetShow) {
            DetailedWorkoutSheet(routineId: routineId, exerciseId: vm.routine.exercises[vm.selectedExercise].id)
        }
        .confirmationDialog(vm.routine.exercises.isEmpty ? "" : vm.routine.exercises[vm.selectedExercise].name , isPresented: $vm.isEditWorkoutActionShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $vm.isAlternateWorkoutSheetShow) {
            AlternateWorkoutSheet(routineId: routineId)
                .environmentObject(vm)
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $vm.isDeleteWorkoutAlertShow) {
            DeleteAlert
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    var WorkoutList: some View {
        VStack {
            HStack {
                // TODO: 부위 별로 수정
                Text(vm.routine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                
                Spacer()
            }
            
            ScrollView {
                ForEach(0..<vm.routine.exercises.count, id: \.self) { index in
                    WorkoutListCell(index: index)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func WorkoutListCell(index: Int) -> some View {
        HStack {
            Button {
                vm.selectedExercise = index
                vm.isDetailedWorkoutSheetShow = true
            } label: {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.fill_1)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                        .overlay {
                            AsyncImage(url: URL(string: vm.routine.exercises[index].exerciseImageUrl)) { image in
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
                        Text(vm.routine.exercises[index].name)
                            .foregroundColor(.label_900)
                            .font(.headline1())
                        HStack {
                            Text("\(vm.routine.exercises[index].numberOfSet)세트")
                                .foregroundColor(.label_700)
                                .font(.body2())
                            Text("|")
                                .foregroundColor(.label_400)
                                .font(.body2())
                            Text("\(vm.routine.exercises[index].recommendReps)회")
                                .foregroundColor(.label_700)
                                .font(.body2())
                        }
                    }
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Button {
                vm.selectedExercise = index
                vm.fetchWorkout(routineId: routineId, exerciseId: vm.routine.exercises[index].id)
                vm.isEditWorkoutActionShow = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.label_700)
            }
            .padding()
        }
    }
    
    var WorkoutStartButton: some View {
        NavigationLink {
            RecordingWorkoutView(routineId: routineId, exerciseId: vm.routine.exercises.first?.id ?? 1)
                .environmentObject(vm)
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
            vm.isAlternateWorkoutSheetShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            vm.isDeleteWorkoutAlertShow = true
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
            vm.deleteWorkout(routineId: routineId, exerciseId: vm.workout.exerciseId)
        }
    }
}

#Preview {
    EditRoutineView(routineId: 1)
}
