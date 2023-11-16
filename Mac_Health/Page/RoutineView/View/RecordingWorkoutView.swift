//
//  RecordingWorkoutView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

/// 운동 시작 했을 때 기록하기 위한 뷰
/// - Parameters:
///  - routineId: 정보를 조회할 루틴의 id
///  - exerciseId: 정보를 조회할 루틴의 운동 id
struct RecordingWorkoutView: View {
    let routineId: Int
    let exerciseId: Int
    
    @StateObject var vm = RecordingWorkoutViewModel()
//    @StateObject var stopwatch = StopwatchViewModel()
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                // TODO: 상단 여백 제거
                ScrollView {
                    WorkoutInfomation
                    WorkoutImageAndTip
                    Spacer()
                    WorkoutSetButton
                    WorkoutSetList
                    RelatedContent
                    EmptyFloatingButton
                }
            }
            
            VStack {
                Spacer()
                isFocused ? nil : WorkoutButton
            }

        }
        .onAppear {
            vm.fetchWorkout(routineId: routineId, exerciseId: exerciseId) {
                editRoutineVM.workout = $0
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
            
            ToolbarItem(placement: .principal) {
                NavigationTitle
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                AlternativeButton
            }
        }
        .navigationBarBackButtonHidden()
        .confirmationDialog(editRoutineVM.workout.name, isPresented: $editRoutineVM.isEditWorkoutActionShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $editRoutineVM.isAlternateWorkoutSheetShow) {
            AlternateWorkoutSheet(routineId: routineId)
                .environmentObject(editRoutineVM)
            
        }
        .sheet(isPresented: $vm.isPauseSheetShow) {
            PauseSheet(viewModel: vm)
                .onTapGesture {
                    isFocused = false
                }
        }
    }
        
        @ViewBuilder
        var NavigationTitle: some View {
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.label_700)
                    .font(.headline2())
                // TODO: 운동 시간
                Text(vm.timeFormatted())
                    .foregroundColor(.label_900)
                    .font(.headline1())
                // TODO: 운동 상태
                Button {
                    vm.isStopAlertShow = true
                    vm.Stop()
                } label: {
                    Circle()
                        .foregroundColor(.gray_700)
                        .frame(width: UIScreen.getWidth(28), height: UIScreen.getHeight(28))
                        .overlay {
                            Image(systemName: "pause.fill")
                                .resizable()
                                .foregroundColor(.label_900)
                                .frame(width: UIScreen.getWidth(11), height: UIScreen.getHeight(14))
                        }
                }
            }
        }
        
        var AlternativeButton: some View {
            Button {
                editRoutineVM.isAlternateWorkoutSheetShow = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.label_700)
                    .font(.headline1())
            }
        }
        
        @ViewBuilder
        var AlternativeActionSheet: some View {
            Button {
                editRoutineVM.isEditWorkoutActionShow = true
            } label: {
                Text("운동 대체")
            }
            
            Button {
                // TODO: .
            } label: {
                Text("삭제")
            }
            
            
            Button(role: .cancel) {
                // TODO: .
            } label: {
                Text("취소")
            }
        }
        
        var WorkoutInfomation: some View {
            VStack {
                HStack {
                    // TODO: 운동 리스트
                    Text("\(editRoutineVM.selectedExercise + 1) / \(editRoutineVM.routine.exercises.count)")
                        .foregroundColor(.label_700)
                    Text("|")
                        .foregroundColor(.label_400)
                    Text(editRoutineVM.workout.part)
                        .foregroundColor(.label_700)
                    Spacer()
                }
                .font(.body2())
                
                Spacer()
                
                HStack {
                    Text(editRoutineVM.workout.name)
                        .font(.title1())
                        .foregroundColor(.label_900)
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        
        var WorkoutImageAndTip: some View {
            TabView(selection: $vm.tabSelection){
                ZStack {
                    AsyncImage(url: URL(string: editRoutineVM.workout.exerciseImageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray_600)
                    }
                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(230))
                    .padding()
                    
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.label_500)
                        Button {
                            withAnimation {
                                vm.tabSelection = 1
                            }
                        } label: {
                            // TODO: 팁 사이즈 바꾸기 - 지금 오른쪽 라디우스 나옴
                            RoundedRectangle(cornerRadius: 8.0)
                                .frame(width: UIScreen.getWidth(43), height: UIScreen.getHeight(68))
                                .foregroundColor(.fill_1)
                                .overlay {
                                    Text("팁")
                                        .foregroundColor(.green_main)
                                }
                        }
                    }
                    .font(.button2())
                }
                .tag(0)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7.2)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                        .foregroundColor(.gray_800)
                        .overlay {
                            VStack {
                                HStack {
                                    AsyncImage(url: URL(string: editRoutineVM.workout.faceImageUrl)) { image in
                                        image
                                            .resizable()
                                    } placeholder: {
                                        Image(systemName: "arrow.triangle.2.circlepath")
                                            .resizable()
                                            .foregroundColor(.gray_600)
                                            .padding()
                                    }
                                    .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                                    Spacer()
                                }
                                Spacer()
                                
                                Text(editRoutineVM.workout.tip)
                                    .font(.body())
                                    .foregroundColor(.label_900)
                                Spacer()
                                Spacer()
                            }
                            .padding()
                        }
                }
                .tag(1)
            }
            .frame(height: UIScreen.getHeight(300))
            .tabViewStyle(.page)
        }
        
        var WorkoutSetButton: some View {
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: UIScreen.getWidth(106), height: UIScreen.getHeight(36))
                    .foregroundColor(.gray_700)
                    .overlay {
                        HStack {
                            Button {
                                vm.decreaseSetCount(routineId: routineId, exerciseId: editRoutineVM.workout.exerciseId) {
                                    editRoutineVM.workout.sets = $0
                                }
                            } label: {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: UIScreen.getWidth(18), height: UIScreen.getHeight(18))
                                    .overlay {
                                        Image(systemName: "minus")
                                            .foregroundColor(.label_900)
                                    }
                            }
                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                            
                            Text("\(editRoutineVM.workout.sets.count)세트")
                                .foregroundColor(.label_700)
                            
                            Button {
                                vm.increseSetCount(routineId: routineId, exerciseId: editRoutineVM.workout.exerciseId) {
                                    editRoutineVM.workout.sets = $0
                                }
                            } label: {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: UIScreen.getWidth(18), height: UIScreen.getHeight(18))
                                    .overlay {
                                        Image(systemName: "plus")
                                            .foregroundColor(.label_900)
                                    }
                            }
                        }
                        .font(.body())
                    }
                Spacer()
            }
            .padding()
        }
        
        @ViewBuilder
        var WorkoutSetList: some View {
            if !editRoutineVM.workout.sets.isEmpty {
                ForEach(0..<editRoutineVM.workout.sets.count, id: \.self) { index in
                    // TODO: 무게 조정 api 호출
                    WorkoutSetCard(index: index, routineId: routineId, exerciseId: exerciseId, set: $editRoutineVM.workout.sets[index], isFocused: $isFocused)
                        .environmentObject(vm)
                        .overlay {
                            if index == vm.currentSet {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(52))
                                    .foregroundColor(.green_main)
                            }
                        }
                }
            }
        }
        
        var WorkoutButton: some View {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(76))
                .foregroundColor(.gray_600)
                .overlay {
                    HStack {
                        NavigationLink {
                            RecordingRoutineView()
                                .environmentObject(editRoutineVM)
                        } label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.green_main)
                                .font(.title1())
                                .padding(.leading)
                        }
                        
                        Spacer()
                        
                        Button {
                            // TODO: 루틴 완료
                            if vm.currentSet == editRoutineVM.workout.sets.count - 1 {
                                // TODO: 운동 완료
                            }
                            else {
                                vm.finishSet(routineId: routineId, exerciseId: exerciseId, setId: editRoutineVM.workout.sets[vm.currentSet].setId) {
                                    editRoutineVM.workout.sets[vm.currentSet].reps = $0.reps
                                    editRoutineVM.workout.sets[vm.currentSet].weight = $0.weight
                                    editRoutineVM.workout.sets[vm.currentSet].isDone = $0.isDone
                                    vm.currentSet += 1
                                }
                            }
                        } label: {
                            if vm.currentSet == editRoutineVM.workout.sets.count - 1 {
                                RoundedRectangle(cornerRadius: 100)
                                    .frame(width: UIScreen.getWidth(132), height: UIScreen.getHeight(60))
                                    .foregroundColor(.red_main)
                                    .overlay {
                                        Text("운동 완료")
                                            .font(.button1())
                                            .foregroundColor(.label_900)
                                    }
                            }
                            else {
                                RoundedRectangle(cornerRadius: 100)
                                    .frame(width: UIScreen.getWidth(132), height: UIScreen.getHeight(60))
                                    .foregroundColor(.green_main)
                                    .overlay {
                                        HStack{
                                            Text("다음 세트")
                                                .font(.button1())
                                            Image(systemName: "chevron.right")
                                                .font(.button2())
                                        }
                                        .foregroundColor(.gray_900)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .bold()
                }
        }
        
        var RelatedContent: some View {
            VStack {
                HStack {
                    Text("관련 영상")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    // TODO: 유튜브 카드 수정 후 고치기
                    RelatedContentCard()
                    //                ForEach(workoutOngoingVM.workoutModel.relatedContentURL.indices) { index in
                    //                    HStack{
                    //                        RelatedContentCard(videoNum: 1, contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                    //                        RelatedContentCard(videoNum: 1, contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                    //                    }
                    //                }
                }
            }
            .padding(.horizontal)
        }
        
        var EmptyFloatingButton: some View {
            FloatingButton(backgroundColor: .clear) { }
        }
        
        @ViewBuilder
        var BackButton: some View {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.label_700)
                    .font(.headline1())
            }
        }
}

#Preview {
    RecordingWorkoutView(routineId: 2, exerciseId: 7)
}
