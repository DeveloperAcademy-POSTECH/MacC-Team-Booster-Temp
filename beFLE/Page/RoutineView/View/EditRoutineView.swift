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
    
    let routineId: Int
    @StateObject var vm = EditRoutineViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            WorkoutList
            gradient
            WorkoutStartButton
        }
        .onAppear {
            vm.fetchRoutine(routineId: routineId)
        }
        .navigationTitle("운동 목록 편집")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $vm.isDetailedWorkoutSheetShow) {
            DetailedWorkoutSheet(routineId: routineId, exerciseId: vm.routine.exercises[vm.selectedIndex].id)
        }
        .confirmationDialog(vm.routine.exercises.isEmpty ? "" : vm.routine.exercises[vm.selectedIndex].name , isPresented: $vm.isEditWorkoutActionShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $vm.isAlternateWorkoutSheetShow) {
            AlternateWorkoutSheet(routineId: routineId, exerciseId: vm.routine.exercises[vm.selectedIndex].id)
                .environmentObject(vm)
                .onDisappear{
                    vm.fetchRoutine(routineId: routineId)
                }
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
                .font(.headline2())
        }
    }
    
    var WorkoutList: some View {
        VStack {
            HStack {
                Text(vm.routine.part)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding([.horizontal, .top])
                
                Spacer()
            }
            
            ScrollView {
                ForEach(0..<vm.routine.exercises.count, id: \.self) { index in
                    WorkoutListCell(index: index)
                        .padding(.vertical, 4)
                }
                .padding(.horizontal)
                FloatingButton(backgroundColor: .clear) { }
                    .padding()
            }
            
        }
        .padding(.horizontal)
        
    }
    
    func WorkoutListCell(index: Int) -> some View {
        HStack {
            Button {
                vm.selectedIndex = index
                vm.isDetailedWorkoutSheetShow = true
            } label: {
                HStack(spacing: 8){
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.fill_1)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                        .overlay {
                            AsyncImage(url: URL(string: vm.routine.exercises[index].exerciseImageUrl)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .scaledToFit()
                                    .scaleEffect(CGSize(width: 1.0, height: 1.0))
                                    .foregroundColor(.label_400)
                                    .padding()
                            }
                        }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(vm.routine.exercises[index].name)
                            .foregroundColor(.label_900)
                            .font(.headline1())
                            .multilineTextAlignment(.leading)
                        HStack(spacing: 3){
                            Text("\(vm.routine.exercises[index].numberOfSet)세트")
                                .foregroundColor(.label_700)
                                .font(.body2())
                            Text("|")
                                .foregroundColor(.label_400)
                                .font(.body2())
                                .scaleEffect(0.8)
                            Text("\(vm.routine.exercises[index].recommendReps)회")
                                .foregroundColor(.label_700)
                                .font(.body2())
                        }
                    }
                    .padding()
                    
                    Spacer()
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
        }
    }
    
    var gradient: some View{
        VStack{
            Spacer()
            LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
    
    var WorkoutStartButton: some View {
        VStack{
            Spacer()
            NavigationLink {
                RecordingWorkoutView(routineId: routineId, exerciseId: vm.routine.exercises.isEmpty ? 0 : vm.routine.exercises[vm.currentWorkoutIndex].id, burnedKCalories: vm.routine.burnedKCalories)
                    .environmentObject(vm)
            } label: {
                FloatingButton(backgroundColor: .green_main) {
                    Text("시작")
                        .foregroundColor(.gray_900)
                        .font(.button1())
                }
                .padding()
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
        
        Button(role: .destructive) {
            vm.isDeleteWorkoutAlertShow = true
        } label: {
            Text("삭제")
        }
        
        Button(role: .cancel) { }
        label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var DeleteAlert: some View {
        Button("삭제", role: .destructive) {
            vm.deleteWorkout(routineId: routineId, exerciseId: vm.workout.exerciseId)
        }
    }
}

//#Preview {
//    EditRoutineView(routineId: 1)
//}
