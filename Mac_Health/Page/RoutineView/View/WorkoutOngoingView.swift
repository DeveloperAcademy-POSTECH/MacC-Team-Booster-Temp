//
//  WorkoutOngoingView.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

struct WorkoutOngoingView: View {
    // TODO: 몇 번째 운동 작업
    let routineId: Int
    let exerciseId: Int
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = WorkoutOngoingViewModel()
    
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
                WorkoutButton
            }
        }
        .onAppear {
            vm.fetchExercise(routineId: routineId, exerciseId: exerciseId)
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
        .confirmationDialog(vm.routine.name, isPresented: $vm.isAlternativeShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .sheet(isPresented: $vm.isAlternativeSheetShow) {
            AlternativeWorkoutSheet(baseExercise: vm.routine.name, baseRoutineId: routineId, baseExerciseId: exerciseId, alternativeExercise: vm.routine.alternativeExercises)
        }
        //        .alert("운동을 중단하시겠습니까?", isPresented: $exitAlertShow) {
        //            Button("운동중단") {
        //                // MARK: 취소
        //            }
        //            Button("취소") {
        //                // MARK: 완료하기
        ////                routineVM.showWorkOutOnGoing.toggle()
        //            }
        //        }
        //        //운동 완료 후 창닫기
        //        .alert("운동을 완료할까요?", isPresented: $vm.isWorkoutFinishAlertShow) {
        //            Button("취소") {
        //                // MARK: 취소
        //            }
        //            NavigationLink("완료하기") {
        //                // MARK: 완료하기
        //                WorkoutFinishView()
        //            }
        //        }
        //        .alert(isPresented: $isDeleteAlertShow) {
        //            Alert(
        //                title: Text("운동을 삭제하시겠습니까?"),
        //                message: Text(""),
        //                primaryButton: .destructive(Text("삭제"),
        //                                            action: {
        //
        //                                            }),
        //                secondaryButton: .cancel(Text("취소"))
        //            )
        //        }
        //        .alert(isPresented: $isDeleteAlertShow) {
        //            Alert(
        //                title: Text("운동을 삭제하시겠습니까?"),
        //                message: Text(""),
        //                primaryButton: .destructive(Text("삭제"),
        //                                            action: {
        //
        //                                            }),
        //                secondaryButton: .cancel(Text("취소"))
        //            )
        //        }
        //        //MARK: 운동 완료는 했지만 운동이 존재할 경우
        //        .alert(isPresented: $existUnfinished) {
        //            Alert(
        //                title: Text("완료하지 않은 운동이 있습니다/n해당 운동을 확인하시겠습니까?"),
        //                message: Text(""),
        //                primaryButton: .destructive(Text("운동완료"),
        //                                            action: {
        //
        //                                            }),
        //                secondaryButton: .destructive(Text("확인"),
        //                                              action: {
        //
        //                                              })
        //            )
        //        }
        .sheet(isPresented: $vm.isPauseShow) {
            // TODO: 타이머 붙이기
            PauseSheet()
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    var NavigationTitle: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundColor(.label_700)
                .font(.headline2())
            // TODO: 운동 시간
            Text("00:00:00")
                .foregroundColor(.label_900)
                .font(.headline1())
            // TODO: 운동 상태
            Button {
                vm.isPauseShow = true
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
            vm.isAlternativeShow = true
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            vm.isAlternativeSheetShow = true
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
                Text("3 / 10")
                    .foregroundColor(.label_700)
                Text("|")
                    .foregroundColor(.label_400)
                Text(vm.routine.part)
                    .foregroundColor(.label_700)
                Spacer()
            }
            .font(.body2())
            
            Spacer()
            
            HStack {
                Text(vm.routine.name)
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
                AsyncImage(url: URL(string: vm.routine.exerciseImageUrl)) { image in
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
                                AsyncImage(url: URL(string: vm.routine.faceImageUrl)) { image in
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
                            
                            Text(vm.routine.tip)
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
                            vm.deleteDecreaseSet(routineId: routineId, exerciseId: exerciseId)
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
                        
                        Text("\(vm.routine.sets.count)세트")
                            .foregroundColor(.label_700)
                        
                        Button {
                            vm.postIncreaseSet(routineId: routineId, exerciseId: exerciseId)
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
        if !vm.routine.sets.isEmpty {
            ForEach(0..<vm.routine.sets.count, id: \.self) { index in
                WorkoutSetCard(index: index + 1, set: $vm.routine.sets[index])
                    .overlay {
                        if index == vm.currentSetIndex {
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
                        WorkoutStatusView()
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.green_main)
                            .font(.title1())
                            .padding(.leading)
                    }
                    
                    Spacer()
                    
                    Button {
                        vm.workoutSetController(routineId: routineId, excerciseId: exerciseId)
                    } label: {
                        if vm.currentSetIndex == vm.routine.sets.count - 1 {
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
                RelatedContentCard(videoNum: 0, contentURL: "")
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
}

struct WorkoutOngoingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkoutOngoingView(routineId: 1, exerciseId: 1)
        }
    }
}
