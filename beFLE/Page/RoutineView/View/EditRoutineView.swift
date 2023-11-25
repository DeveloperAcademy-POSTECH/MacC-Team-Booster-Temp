//
//  EditRoutineView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 시작 했을 때 운동 시작하기 전 운동 목록 편집하는 뷰
/// - Parameters:
///  - routineId: 수정할 루틴에 대한 id
struct EditRoutineView: View {
    @StateObject var vm = EditRoutineViewModel()
    @EnvironmentObject var workoutViewModel: WorkoutViewModel
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            WorkoutList
            gradient
            WorkoutStartButton
        }
        .navigationTitle("운동 목록 편집")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
    }
}

/// 네비게이션 타이틀
extension EditRoutineView {
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline2())
        }
    }
}

/// 운동 목록
extension EditRoutineView {
    var WorkoutList: some View {
        VStack {
            HStack {
                Text(workoutViewModel.routine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding([.horizontal, .top])
                
                Spacer()
            }
            
            ScrollView {
                ForEach(Array(workoutViewModel.routine.exercises.enumerated()), id: \.element) { pair in
                    WorkoutListCell(pair.offset, pair.element)
                        .padding(.vertical, 4)
                }
                .padding(.horizontal)
                FloatingButton(size: .medium) {}
                    .padding()
            }
            
        }
        .padding(.horizontal)
    }
    
    func WorkoutListCell(_ index: Int, _ exercise: Exercise) -> some View {
        HStack {
            Button {
                workoutViewModel.fetchExerciseId(exerciseId: exercise.id)
                vm.isDetailedWorkoutSheetShow = true
            } label: {
                HStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.fill_1)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                        .overlay {
                            AsyncImage(url: URL(string: exercise.exerciseImageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                LottieView()
                                    .padding(5)
                            }
                        }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(exercise.name)
                            .foregroundColor(.label_900)
                            .font(.headline1())
                            .multilineTextAlignment(.leading)
                            .allowsTightening(true)
                        HStack(spacing: 3){
                            Text("\(exercise.numberOfSet)세트")
                                .foregroundColor(.label_700)
                                .font(.body2())
                            Text("|")
                                .foregroundColor(.label_400)
                                .font(.body2())
                                .scaleEffect(0.8)
                            Text("\(exercise.recommendReps)회")
                                .foregroundColor(.label_700)
                                .font(.body2())
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .sheet(isPresented: $vm.isDetailedWorkoutSheetShow) {
                if workoutViewModel.exercise != nil {
                    DetailedWorkoutSheet(exercise: workoutViewModel.exercise!)
                }
            }
            
            Spacer()
            
            Button {
                vm.selectedIndex = index
                vm.isEditWorkoutActionShow = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.label_700)
            }
            .padding()
            .confirmationDialog(exercise.name, isPresented: $vm.isEditWorkoutActionShow, titleVisibility: .visible) {
                AlternativeActionSheet
            }
        }
    }
    
    var gradient: some View {
        VStack {
            Spacer()
            LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
    
    var WorkoutStartButton: some View {
        VStack {
            Spacer()
            NavigationLink {
                RecordingWorkoutView(routineId: workoutViewModel.routineId, exerciseId: workoutViewModel.routine.exercises.isEmpty ? 0 : workoutViewModel.routine.exercises[vm.currentWorkoutIndex].id, burnedKCalories: workoutViewModel.routine.burnedKCalories)
                    .environmentObject(vm)
            } label: {
                FloatingButton(size: .medium, color: .green_main) {
                    Text("시작")
                        .foregroundColor(.gray_900)
                        .font(.button1())
                }
                .padding()
            }
        }
    }
}

/// 시트, 얼럿, 액션
extension EditRoutineView {
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            vm.isAlternateWorkoutSheetShow = true
        } label: {
            Text("운동 대체")
        }
        .sheet(isPresented: $vm.isAlternateWorkoutSheetShow) {
            AlternateWorkoutSheet(routineId: workoutViewModel.routineId, exerciseId: vm.routine.exercises[vm.selectedIndex].id)
                .environmentObject(vm)
                .onDisappear {
                    workoutViewModel.fetchRoutine()
                }
        }
        
        Button(role: .destructive) {
            vm.isDeleteWorkoutAlertShow = true
        } label: {
            Text("삭제")
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $vm.isDeleteWorkoutAlertShow) {
            DeleteAlert
        }
        
        Button(role: .cancel) {
            
        } label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var DeleteAlert: some View {
        Button("삭제", role: .destructive) {
            vm.deleteWorkout(routineId: workoutViewModel.routineId, exerciseId: vm.workout.exerciseId)
        }
    }
}

//#Preview {
//    EditRoutineView(routineId: 1)
//}
