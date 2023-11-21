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
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
    var burnedKCalories: Int
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    
    var body: some View {
        if vm.isFinish {
            RecordingFinishView(routineId: routineId, elapsedTime: $vm.elapsedTime, recordViewModel: vm, burnedKCalories: burnedKCalories)
        }
        else {
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
                        EmptyFloatingButton
                    }
                }
                
                VStack{
                    Spacer()
                    isFocused ? nil :
                    LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                        .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                        .onTapGesture {
                            // Handle taps on the LinearGradient if needed
                        }
                        .allowsHitTesting(false)
                }
                .ignoresSafeArea()

                
                VStack {
                    Spacer()
                    isFocused ? nil : WorkoutButton
                }
                
            }
            .onAppear {
                //TODO: 관련 영상 호출 필요 - MORO
                vm.start()
                editRoutineVM.fetchWorkout(routineId: routineId, exerciseId: exerciseId)
            }
            .onDisappear{
                vm.stop()
            }
            .onTapGesture {
                isFocused = false
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    StopButton
                }
                
                ToolbarItem(placement: .principal) {
                    NavigationTitle
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    ActionSheet
                }
            }
            .navigationBarBackButtonHidden()
            .confirmationDialog(editRoutineVM.workout.name, isPresented: $editRoutineVM.isEditWorkoutActionShow, titleVisibility: .visible) {
                AlternativeActionSheet
            }
            .sheet(isPresented: $editRoutineVM.isAlternateWorkoutSheetShow) {
                AlternateWorkoutSheet(routineId: routineId, exerciseId: exerciseId)
                    .environmentObject(editRoutineVM)
                
            }
            .sheet(isPresented: $vm.isPauseSheetShow) {
                PauseSheet(viewModel: vm)
            }
            .alert("운동을 중단하시겠습니까?", isPresented: $vm.isStopAlertShow) {
                WorkoutStopAlert
            } message: {
                Text("운동기록은 삭제됩니다.")
            }
            .alert("완료하지 않은 운동이 있습니다\n해당 운동을 확인하시겠습니까?", isPresented: $vm.isDiscontinuewAlertShow) {
                Button {
                    vm.finishWorkout(routineId: routineId)
                } label: {
                    Text("운동완료")
                }
                
                Button {
                    
                } label: {
                    Text("확인")
                }
            }
        }
    }
    
    @ViewBuilder
    var NavigationTitle: some View {
        HStack (spacing: 0){
            Image(systemName: "flame.fill")
                .foregroundColor(.green_main)
                .font(.headline2())
            // TODO: 운동 시간
            Text(vm.timeFormatted())
                .foregroundColor(.label_900)
                .font(.headline1())
                .padding(.horizontal, 10)
            // TODO: 운동 상태
            Button {
                vm.isPauseSheetShow = true
                vm.stop()
            } label: {
                Circle()
                    .foregroundColor(.gray_700)
                    .frame(width: UIScreen.getWidth(28), height: UIScreen.getHeight(28))
                    .overlay {
                        Image(systemName: "pause.fill")
                            .font(.caption())
                            .scaleEffect(0.8)
                            .foregroundColor(.label_900)
                    }
            }
        }
    }
    
    var ActionSheet: some View {
        Button {
            editRoutineVM.isEditWorkoutActionShow = true
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.label_700)
                .font(.headline1())
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
            // TODO: .
        } label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var WorkoutStopAlert: some View {
        Button("운동중단") {
            // TODO: 운동 중단
            dismiss()
        }
        Button("취소") {
            
        }
    }
    
    var WorkoutInfomation: some View {
        VStack {
            HStack {
                // TODO: 운동 리스트
                Text("\(editRoutineVM.currentWorkoutIndex + 1) / \(editRoutineVM.routine.exercises.count)")
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
        .padding(.top)
    }
    
    var WorkoutImageAndTip: some View {
        TabView(selection: $vm.tabSelection){
                VStack{
                    ZStack{
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
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                        .padding(.horizontal)
                        
                        HStack {
                            Spacer()
                            Image(systemName: "chevron.backward")
                                .foregroundColor(.label_500)
                            Button {
                                withAnimation {
                                    vm.tabSelection = 1
                                }
                            } label: {
                                RoundedShape(corners: [.topLeft, .bottomLeft])
                                    .frame(width: UIScreen.getWidth(43), height: UIScreen.getHeight(68))
                                    .foregroundColor(.fill_1)
                                    .overlay {
                                        Text("팁")
                                            .foregroundColor(.green_main)
                                    }
                            }
                        }
                    }
                    .font(.button2())
                    Spacer()
                        .frame(height: UIScreen.getHeight(50))
                }
            .tag(0)
            
            ZStack {
                VStack{
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
                                    .padding(.horizontal, 5)
                                    .padding(.top, 4)
                                    Spacer()
                                }
                                Spacer()
                                
                                Text(editRoutineVM.workout.tip)
                                    .font(.body())
                                    .foregroundColor(.label_900)
                                    .padding(.horizontal, 1.9)
                                    .lineSpacing(6.0)
                                Spacer()
                                Spacer()
                            }
                            .padding()
                        }
                    Spacer()
                        .frame(height: UIScreen.getHeight(50))
                }
            }
            .tag(1)
        }
        .frame(height: UIScreen.getHeight(270))
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
                                if editRoutineVM.workout.sets.count > 1 {
                                    vm.decreaseSetCount(routineId: routineId, exerciseId: exerciseId) {
                                        editRoutineVM.workout.sets = $0
                                    }
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
                            .disabled(editRoutineVM.workout.sets.count <= 1)
                            
                            Text("\(editRoutineVM.workout.sets.count)세트")
                                .foregroundColor(.label_700)
                            
                            Button {
                                if editRoutineVM.workout.sets.count < 10 {
                                    vm.increseSetCount(routineId: routineId, exerciseId: exerciseId) {
                                        editRoutineVM.workout.sets = $0
                                    }
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
                            .disabled(editRoutineVM.workout.sets.count >= 10)
                        }
                        .font(.body())
                    }
                Spacer()
            }
            .padding(.bottom)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    var WorkoutSetList: some View {
        VStack{
            if !editRoutineVM.workout.sets.isEmpty {
                ForEach(0..<editRoutineVM.workout.sets.count, id: \.self) { index in
                    // TODO: 무게 조정 api 호출
                    WorkoutSetCard(index: index + 1, routineId: routineId, exerciseId: exerciseId, set: $editRoutineVM.workout.sets[index], isFocused: $isFocused)
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
        .padding(.bottom, 30)
    }
    
    var WorkoutButton: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(76))
            .foregroundColor(.gray_700)
            .overlay {
                HStack {
                    NavigationLink {
                        RecordingRoutineView(routineId: routineId, burnedKCalories: burnedKCalories)
                            .environmentObject(editRoutineVM)
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.green_main)
                            .font(.title1())
                            .padding(.leading, 30)
                    }
                    
                    Spacer()
                    
                    // MARK: 다음 세트, 운동, 운동 완료 버튼
                    Button {
                        if vm.currentSet == editRoutineVM.workout.sets.count - 1 {
                            if editRoutineVM.currentWorkoutIndex + 1 == editRoutineVM.routine.exercises.count {
                                vm.finishSet(routineId: routineId, exerciseId: exerciseId, setId: editRoutineVM.workout.sets[vm.currentSet].setId) { _ in
                                    editRoutineVM.workout.sets[vm.currentSet].isDone = true
                                    
                                    for exercise in editRoutineVM.routine.exercises {
                                        if exercise.isDone == false {
                                            vm.isDiscontinuewAlertShow = true
                                            return
                                        }
                                    }
                                     
                                    vm.finishWorkout(routineId: routineId)
                                }
                            }
                            else {
                                vm.finishSet(routineId: routineId, exerciseId: exerciseId, setId: editRoutineVM.workout.sets[vm.currentSet].setId) { _ in
                                    editRoutineVM.workout.sets[vm.currentSet].isDone = true
                                    
                                    editRoutineVM.currentWorkoutIndex += 1
                                    editRoutineVM.fetchWorkout(routineId: routineId, exerciseId: editRoutineVM.routine.exercises[editRoutineVM.currentWorkoutIndex].id)
                                    if editRoutineVM.currentWorkoutIndex != editRoutineVM.routine.exercises.count {
                                        vm.currentSet = 0
                                    }
                                }
                            }
                        }
                        else {
                            vm.finishSet(routineId: routineId, exerciseId: exerciseId, setId: editRoutineVM.workout.sets[vm.currentSet].setId) {
                                editRoutineVM.workout.sets[vm.currentSet].reps = $0.reps
                                if $0.weight != nil {
                                    editRoutineVM.workout.sets[vm.currentSet].weight = $0.weight
                                }
                                editRoutineVM.workout.sets[vm.currentSet].isDone = $0.isDone
                                vm.currentSet += 1
                            }
                        }
                    } label: {
                        if vm.currentSet == editRoutineVM.workout.sets.count - 1 {
                            if editRoutineVM.currentWorkoutIndex + 1 == editRoutineVM.routine.exercises.count {
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
                                            Text("다음 운동")
                                                .font(.button1())
                                            Image(systemName: "chevron.right")
                                                .font(.button2())
                                        }
                                        .foregroundColor(.gray_900)
                                    }
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
                    .disabled(!vm.isCanTappable)
                    //: - 다음 버튼
                }
                .padding(.trailing, 8)
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
                HStack{
                    // TODO: 유튜브 링크 통해서 작업하기
                    ForEach(editRoutineVM.workout.videoUrls, id: \.self) { videoUrl in
                        RelatedContentCard(videoID: videoUrl)
                    }
                }
                //                ForEach(workoutOngoingVM.workoutModel.relatedContentURL.indices) { index in
                //                    HStack{
                //                        RelatedContentCard(videoNum: 1, contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                //                        RelatedContentCard(videoNum: 1, contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                //                    }
                //                }
            }
        }
        .padding()
    }
    
    var EmptyFloatingButton: some View {
        FloatingButton(backgroundColor: .clear) { }
    }
    
    @ViewBuilder
    var StopButton: some View {
        Button {
            vm.isStopAlertShow = true
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
}

//#Preview {
//    RecordingWorkoutView(routineId: 0, exerciseId: 0)
//}
