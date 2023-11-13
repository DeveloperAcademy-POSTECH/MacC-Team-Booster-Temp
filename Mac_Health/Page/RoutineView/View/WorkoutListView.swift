//
//  WorkoutListView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/4/23.
//

import SwiftUI

struct WorkoutListView: View {
    let routineId: Int
    
    @StateObject var vm = WorkoutListViewModel()
    @Environment(\.dismiss) var dismiss
    
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
        .sheet(isPresented: $vm.isDetailedWorkoutShow) {
            DetailedWorkoutSheet(routineId: routineId, exerciseId: vm.routine.exercises[vm.selectedExercise].id)
        }
        .confirmationDialog(vm.selectedExercise == -1 ? "" : vm.routine.exercises[vm.selectedExercise].name , isPresented: $vm.isConfirmationDialogShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $vm.isAlternativeWorkoutSheetShow) {
            // TODO: 대체 운동
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $vm.isDeleteAlertShow) {
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
                vm.isDetailedWorkoutShow = true
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
                            //                    Text("|")
                            //                        .foregroundColor(.label_400)
                            //                        .font(.body2())
                            // TODO: reps 추가
                            //                    Text("10-15회")
                            //                        .foregroundColor(.label_700)
                            //                        .font(.body2())
                        }
                    }
                    
                    Spacer()
                }
            }
    
            Spacer()
            
            Button {
                vm.selectedExercise = index
                vm.isConfirmationDialogShow = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.label_700)
            }
            .padding()
        }
    }
    
    var WorkoutStartButton: some View {
        NavigationLink {
            // TODO: 운동 1 / 10
//            WorkoutOngoingView(routineId: routineId, exerciseId: )
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
            // TODO: .
        } label: {
            Text("운동 대체")
        }
        
        Button {
            vm.isDeleteAlertShow = true
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

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView(routineId: 1)
    }
}
