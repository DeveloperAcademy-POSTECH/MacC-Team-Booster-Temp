//
//  RecordingWorkoutView.swift
//  beFLE
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

enum NextButtonStatus {
    case nextSet
    case nextWorkout
    case finishWorkout
}

/// 운동 시작 했을 때 기록하기 위한 뷰
struct RecordingWorkoutView: View {
    @FocusState var isFocused: Bool
    @Namespace var topID
    @Namespace var refreshID
    
    @StateObject var vm = RecordingWorkoutViewModel()
    @EnvironmentObject var workoutVM: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            ScrollViewReader { proxy in
                ZStack {
                    ScrollView {
                        TopSpace
                        WorkoutInfomation
                        WorkoutImageAndTip
                        Spacer()
                        WorkoutSetButton
                        WorkoutSetList
                        RelatedContent
                        FloatingButton(size: .medium) {}
                    }
                    .scrollIndicators(.hidden)
                    
                    bottomGradientView(proxy: proxy)
                    workoutButton(proxy: proxy)
                }
            }
        }
        .onAppear {
            workoutVM.caculateBackgroundTime()
            workoutVM.startTimer()
            vm.currentSet = 0
        }
        .onDisappear {
            vm.currentSet = 0
            workoutVM.stopTimer()
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
        .confirmationDialog(workoutVM.workout.name, isPresented: $vm.isEditWorkoutActionShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $vm.isAlternateWorkoutSheetShow) {
            AlternateWorkoutSheet(routineId: workoutVM.routineId, exerciseId: workoutVM.exerciseId)
        }
        .alert("운동을 삭제하시겠습니까?", isPresented: $vm.isDeleteWorkoutAlertShow) {
            DeleteAlert
        }
        .alert("완료하지 않은 운동이 있습니다\n해당 운동을 확인하시겠습니까?", isPresented: $vm.isDiscontinuewAlertShow) {
            DiscontinueAlert
        }
    }
}

/// 네비게이션 타이틀 및 얼럿, 액션, 시트
extension RecordingWorkoutView {
    var TopSpace: some View {
        Spacer()
            .frame(height: 0)
            .id(refreshID)
    }
    
    @ViewBuilder
    var NavigationTitle: some View {
        HStack (spacing: 0) {
            Image(systemName: "flame.fill")
                .foregroundColor(.green_main)
                .font(.headline2())
            
            Text(workoutVM.timeFormatted())
                .foregroundColor(.label_900)
                .font(.headline1())
                .padding(.horizontal, 10)
            
            Button {
                vm.isPauseSheetShow = true
                workoutVM.stopTimer()
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
        .sheet(isPresented: $vm.isPauseSheetShow) {
            PauseSheet()
        }
        .alert("운동을 중단하시겠습니까?", isPresented: $vm.isStopAlertShow) {
            WorkoutStopAlert
        } message: {
            Text("운동기록은 삭제됩니다.")
        }
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
    
    @ViewBuilder
    var WorkoutStopAlert: some View {
        Button("운동중단") {
            workoutVM.stopTimer()
            dismiss()
        }
        Button("취소") {
            workoutVM.startTimer()
        }
    }
    
    var ActionSheet: some View {
        Button {
            vm.isEditWorkoutActionShow = true
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.label_700)
                .font(.headline1())
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
            
        } label: {
            Text("취소")
        }
    }
    
    @ViewBuilder
    var DiscontinueAlert: some View {
        Button {
            workoutVM.finishSet(setId: workoutVM.workout.sets[vm.currentSet].setId) {
                workoutVM.stopTimer()
                workoutVM.updateWorkoutTime() {
                    vm.isTappable = true
                    workoutVM.finishRoutine()
                }
            }
        } label: {
            Text("운동완료")
        }
        Button {
            workoutVM.changeViewStatus(.recordingRoutineView)
        } label: {
            Text("확인")
        }
    }
    
    @ViewBuilder
    var DeleteAlert: some View {
        Button("삭제", role: .destructive) {
            workoutVM.deleteWorkout()
        }
    }
}

/// 운동 정보 관련
extension RecordingWorkoutView {
    var WorkoutInfomation: some View {
        VStack {
            HStack {
                Text("\(workoutVM.currentWorkoutIndex + 1) / \(workoutVM.routine.exercises.count)")
                    .foregroundColor(.label_700)
                Text("|")
                    .foregroundColor(.label_400)
                Text(vm.exercise.part)
                    .foregroundColor(.label_700)
                Spacer()
            }
            .font(.body2())
            
            Spacer()
            
            HStack {
                Text(workoutVM.workout.name)
                    .font(.title1())
                    .foregroundColor(.label_900)
                    .multilineTextAlignment(.leading)
                    .allowsTightening(true)
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    var WorkoutImageAndTip: some View {
        TabView(selection: $vm.tabSelection) {
            VStack {
                ZStack {
                    LoadingImage(url: workoutVM.workout.exerciseImageUrl)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                        .padding(.horizontal)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(hex: "696969"))
                        Button {
                            withAnimation {
                                vm.tabSelection = 1
                            }
                        } label: {
                            RoundedShape(corners: [.topLeft, .bottomLeft])
                                .frame(width: UIScreen.getWidth(43), height: UIScreen.getHeight(68))
                                .foregroundColor(.gray_700)
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
                VStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                        .foregroundColor(.gray_800)
                        .overlay {
                            ScrollView {
                                VStack {
                                    HStack {
                                        LoadingImage(url: workoutVM.workout.faceImageUrl)
                                            .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                                            .padding(.horizontal, 5)
                                            .padding(.top, 4)
                                        Spacer()
                                    }
                                    .padding(.bottom)
                                    HStack{
                                        Text(workoutVM.workout.tip)
                                            .font(.body())
                                            .foregroundColor(.label_900)
                                            .padding(.horizontal, 1.9)
                                            .lineSpacing(6.0)
                                            .multilineTextAlignment(.leading)
                                            .allowsTightening(true)
                                        Spacer()
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            .scrollIndicators(.hidden)
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
    
    @ViewBuilder
    var RelatedContent: some View {
        if !workoutVM.workout.videoUrls.isEmpty {
            VStack {
                HStack {
                    Text("관련 영상")
                        .font(.title2())
                        .foregroundColor(.label_900)
                    Spacer()
                }
                .padding(.bottom, 13)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(workoutVM.workout.videoUrls, id: \.self) { videoUrl in
                            RelatedContentCard(videoID: videoUrl)
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

/// 운동 세트 관련
extension RecordingWorkoutView {
    var WorkoutSetButton: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(106), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    HStack {
                        Button {
                            vm.isTappable = false
                            workoutVM.decreaseSetCount {
                                if vm.currentSet >= workoutVM.workout.sets.count - 1 {
                                    vm.currentSet -= 1
                                }
                                vm.isTappable = true
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
                        .disabled(!vm.isTappable)
                        
                        Text("\(workoutVM.workout.sets.count)세트")
                            .foregroundColor(.label_700)
                        
                        Button {
                            vm.isTappable = false
                            workoutVM.increseSetCount {
                                vm.isTappable = true
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
                        .disabled(!vm.isTappable)
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
        VStack {
            if !workoutVM.workout.sets.isEmpty {
                ForEach(workoutVM.workout.sets.indices, id: \.self) { index in
                    WorkoutSetCard(index: index + 1, routineId: workoutVM.routineId, exerciseId: workoutVM.exerciseId, set: $workoutVM.workout.sets[index], isFocused: $isFocused)
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
        .padding(.bottom, 70)
        .id(topID)
    }
}

/// 운동 컨트롤 버튼
extension RecordingWorkoutView {
    func bottomGradientView(proxy: ScrollViewProxy) -> some View {
        VStack {
            Spacer()
            if !isFocused {
                LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                    .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                    .allowsHitTesting(false)
            }
        }
        .ignoresSafeArea()
    }
    
    func workoutButton(proxy: ScrollViewProxy) -> some View {
        VStack {
            Spacer()
            if !isFocused {
                FloatingButton(size: .large, color: .gray_700) {
                    HStack {
                        Button {
                            workoutVM.changeViewStatus(.recordingRoutineView)
                        } label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.green_main)
                                .font(.title1())
                                .padding(.leading, 30)
                        }
                        Spacer()
                        
                        // MARK: 다음 세트, 운동, 운동 완료 버튼
                        Button {
                            if vm.currentSet >= workoutVM.workout.sets.count - 1 {
                                withAnimation {
                                    proxy.scrollTo(refreshID, anchor: .bottom)
                                }
                            }
                            else if vm.currentSet == 2 {
                                withAnimation {
                                    proxy.scrollTo(topID, anchor: .bottom)
                                }
                            }
                            
                            if vm.currentSet < workoutVM.workout.sets.count - 1 {
                                vm.isTappable = false
                                workoutVM.finishSet(setId: workoutVM.workout.sets[vm.currentSet].setId) {
                                    workoutVM.workout.sets[vm.currentSet].isDone = true
                                    vm.currentSet += 1
                                    vm.isTappable = true
                                }
                            }
                            else {
                                if workoutVM.currentWorkoutIndex < workoutVM.routine.exercises.count - 1 {
                                    vm.isTappable = false
                                    workoutVM.finishSet(setId: workoutVM.workout.sets[vm.currentSet].setId) {
                                        workoutVM.workout.sets[vm.currentSet].isDone = true
                                        workoutVM.fetchNextWorkout {
                                            vm.currentSet = 0
                                            vm.isTappable = true
                                        }
                                    }
                                }
                                else {
                                    vm.isTappable = false
                                    
                                    if !workoutVM.routine.exercises.filter({ $0.isDone }).isEmpty {
                                        workoutVM.finishSet(setId: workoutVM.workout.sets[vm.currentSet].setId) {
                                            workoutVM.stopTimer()
                                            workoutVM.updateWorkoutTime() {
                                                vm.isTappable = true
                                                workoutVM.finishRoutine()
                                            }
                                        }
                                    }
                                    else {
                                        vm.isDiscontinuewAlertShow = true
                                        vm.isTappable = true
                                    }
                                }
                            }
                        } label: {
                            NextButton
                        }
                        .disabled(!vm.isTappable)
                        //: - 다음 버튼
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }
    
    @ViewBuilder
    var NextButton: some View {
        if vm.currentSet < workoutVM.workout.sets.count - 1 {
            FloatingButton(size: .semiSmall, color: .green_main) {
                HStack {
                    Text("다음 세트")
                        .font(.button1())
                    Image(systemName: "chevron.right")
                        .font(.button2())
                }
                .foregroundColor(.gray_900)
            }
        }
        else {
            if workoutVM.currentWorkoutIndex < workoutVM.routine.exercises.count - 1 {
                FloatingButton(size: .semiSmall, color: .green_main) {
                    HStack {
                        Text("다음 운동")
                            .font(.button1())
                        Image(systemName: "chevron.right")
                            .font(.button2())
                    }
                    .foregroundColor(.gray_900)
                }
            }
            else {
                FloatingButton(size: .semiSmall, color: .red_main) {
                    Text("운동 완료")
                        .font(.button1())
                        .foregroundColor(.label_900)
                }
            }
        }
    }
}
