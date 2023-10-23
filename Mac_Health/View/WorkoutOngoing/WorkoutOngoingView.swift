//
//  WorkoutOngoing.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

struct WorkoutOngoingView: View {
    let currentWorkoutNumber: Int
    @StateObject var workoutOngoingVM = WorkoutOngoingVM()
    // MARK: 임시 이미지 지우기
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                Navigation
                
                ScrollView {
                    Spacer()
                    Spacer()
                    workoutInfomation
                    workoutImage
                    workoutSetButton
                    workoutSetCard
                    relatedContent
                    emptyFloatingButton
                }
            }
            
            VStack {
                Spacer()
                workoutTipButton
                Spacer()
                Spacer()
                workouFloatingButton
            }
        }
        .sheet(isPresented: $workoutOngoingVM.isRoutineSequenceShow) {
            workoutSequenceSheet
        }
        .sheet(isPresented: $workoutOngoingVM.isAlternativeWorkoutShow) {
            alternativeWorkoutSheet
        }
        .alert("운동을 완료할까요?", isPresented: $workoutOngoingVM.isWorkoutFinishAlertShow) {
            Button("취소") {
                // MARK: 취소
            }
            Button("완료하기") {
                // MARK: 완료하기
            }
        }
    }
    
    @ViewBuilder
    var Navigation: some View {
        HStack {
            Button {
                // MARK: dismiss
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(.label_700)
            }
            Spacer()
            
            Group {
                Image(systemName: "flame.fill")
                    .foregroundColor(.green_main)
                Text("00:00:00")
                    .foregroundColor(.label_900)
            }
            .font(.headline1())
            Spacer()
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var workoutInfomation: some View {
        VStack {
            HStack {
                Text(workoutOngoingVM.workoutModel.workoutDate)
                    .foregroundColor(.label_700)
                Text("|")
                    .foregroundColor(.label_400)
                Text(workoutOngoingVM.workoutModel.influencerName)
                    .foregroundColor(.label_700)
                Text("|")
                    .foregroundColor(.label_400)
                Text("\(currentWorkoutNumber)/10")
                    .foregroundColor(.label_700)
                Spacer()
            }
            .font(.body2())
            
            HStack {
                Text(workoutOngoingVM.workoutModel.workoutName)
                    .font(.title1())
                    .foregroundColor(.label_900)
                
                Button {
                    workoutOngoingVM.showAlternativeWorkout()
                } label: {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: UIScreen.getWidth(52), height: UIScreen.getHeight(28))
                        .foregroundColor(.gray_700)
                        .overlay {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.2.squarepath")
                                Text("대체")
                            }
                            .font(.caption())
                            .foregroundColor(.label_700)
                        }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var workoutImage: some View {
        Image("tempWorkoutImage")
            .resizable()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
            .foregroundColor(.gray_600)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    var workoutSetButton: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(106), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    HStack {
                        Button {
                            workoutOngoingVM.decreaseWorkoutSet()
                        } label: {
                            Image(systemName: "minus")
                                .foregroundColor(.label_900)
                        }
                        .frame(width: UIScreen.getWidth(28), height: UIScreen.getHeight(28))
                        
                        Text("\(workoutOngoingVM.workoutSet.count)세트")
                            .foregroundColor(.label_700)
                        
                        Button {
                            workoutOngoingVM.increaseWorkoutSet()
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.label_900)
                        }
                        .frame(width: UIScreen.getWidth(28), height: UIScreen.getHeight(28))
                    }
                    .font(.body())
                }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical)
    }
    
    @ViewBuilder
    var workoutSetCard: some View {
        ForEach($workoutOngoingVM.workoutSet) { $workoutSet in
            WorkoutSetCard(workoutSet: $workoutSet)
                .overlay {
                    if workoutSet.index == workoutOngoingVM.currentSet {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(52))
                            .foregroundColor(.green_main)
                    }
                }
        }
    }
    
    @ViewBuilder
    var workouFloatingButton: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
            .foregroundColor(.gray_600)
            .overlay {
                HStack {
                    Button {
                        workoutOngoingVM.showRoutineSequenceShow()
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.label_900)
                    }
                    Spacer()
                    
                    Button {
                        workoutOngoingVM.controlRepetition()
                    } label: {
                        if workoutOngoingVM.workoutSet.count == workoutOngoingVM.currentSet {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(48))
                                .foregroundColor(.red_main)
                                .overlay {
                                    Text("운동 완료")
                                        .font(.button1())
                                        .foregroundColor(.label_900)
                                }
                        }
                        else {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: UIScreen.getWidth(120), height: UIScreen.getHeight(48))
                                .foregroundColor(.green_main)
                                .overlay {
                                    Text("세트 완료")
                                        .font(.button1())
                                        .foregroundColor(.gray_900)
                                }
                        }
                    }
                }
                .padding(.horizontal)
                .bold()
            }
    }
    
    @ViewBuilder
    var workoutSequenceSheet: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("루틴 순서")
                        .font(.title1())
                        .foregroundColor(.label_900)
                    Spacer()
                    
                    Button {
                        workoutOngoingVM.dismissRoutineSequenceShow()
                    } label: {
                        Ellipse()
                            .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                            .foregroundColor(.gray_600)
                            .overlay {
                                Image(systemName: "xmark")
                                    .font(.body())
                                    .foregroundColor(.label_700)
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                Spacer()
                
                VStack {
                    HStack {
                        // MARK: change
                        Text("등")
                            .font(.headline1())
                            .foregroundColor(.label_900)
                        Spacer()
                    }
                    .padding(.horizontal)

                    ScrollView {
                        // MARK: ForEach
                        Button {
                            //
                        } label: {
                            WorkoutSequenceCard(isCurrentWorkout: false, isFinish: true)
                        }
                        Button {
                            //
                        } label: {
                            WorkoutSequenceCard(isCurrentWorkout: false, isFinish: false)
                        }
                    }
                }
                
                Button {
                    workoutOngoingVM.showWorkoutFinishAlert()
                } label: {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                        .foregroundColor(.gray_600)
                        .overlay {
                            Text("운동 완료하기")
                                .font(.button1())
                                .foregroundColor(.red_main)
                        }
                }
                .alert("운동을 완료할까요?", isPresented: $workoutOngoingVM.isWorkoutFinishAlertShow) {
                    Button("취소") {
                        // MARK: 취소
                    }
                    Button("완료하기") {
                        // MARK: 완료하기
                    }
                }
            }
            .padding(.horizontal)
        }
        .presentationDetents([.height(UIScreen.getHeight(684))])
    }
    
    @ViewBuilder
    var alternativeWorkoutSheet: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Group {
                    HStack {
                        Text("운동 대체하기")
                            .font(.title1())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Button {
                            workoutOngoingVM.dismissAlternativeWorkOut()
                        } label: {
                            Ellipse()
                                .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                                .foregroundColor(.gray_600)
                                .overlay {
                                    Image(systemName: "xmark")
                                        .font(.body())
                                        .foregroundColor(.label_700)
                                }
                        }
                    }
                    .padding(.top)
                    
                    HStack {
                        Text("대체할 운동을 선택해주세요")
                            .font(.body())
                            .foregroundColor(.label_700)
                        Spacer()
                    }
                    Spacer()
                }
                
                ScrollView {
                    ForEach(0..<workoutOngoingVM.workoutModel.alternativeWorkout.count) { index in
                        AlternativeWorkoutCard(isSelectedWorkout: currentWorkoutNumber == index ? true : false)
                    }
                }
                
                Button {
                    // MARK: 완료하기
                } label: {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                        .foregroundColor(.green_main)
                        .overlay {
                            Text("완료하기")
                                .font(.button1())
                                .foregroundColor(.gray_900)
                        }
                }
            }
            .padding(.horizontal)
        }
        .presentationDetents([.height(UIScreen.getHeight(519))])
    }
    
    @ViewBuilder
    var relatedContent: some View {
        VStack {
            HStack {
                Text("관련 영상")
                    .font(.title2())
                    .foregroundColor(.label_900)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                ForEach(0..<workoutOngoingVM.workoutModel.relatedContentURL.count) { index in
                    RelatedContentCard(contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var workoutTipButton: some View {
        if !workoutOngoingVM.isWorkoutTipShow {
            HStack {
                Image(systemName: "chevron.backward")
                    .font(.button2())
                    .foregroundColor(.label_500)
                RoundedRectangle(cornerRadius: 7.2)
                    .frame(width: UIScreen.getWidth(315), height: UIScreen.getHeight(68))
                    .foregroundColor(.fill_1)
                    .overlay {
                        HStack {
                            Text("팁")
                                .font(.button2())
                                .foregroundColor(.green_main)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
            }
            .offset(x: UIScreen.getWidth(300))
            .onTapGesture {
                workoutOngoingVM.showWorkoutTip()
            }
        }
        else {
            RoundedRectangle(cornerRadius: 7.2)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                .foregroundColor(.gray_800)
                .overlay {
                    VStack {
                        HStack {
                            Text("\(workoutOngoingVM.workoutModel.influencerName)'s Tip")
                                .font(.headline2())
                                .foregroundColor(.label_700)
                            Spacer()
                            Button {
                                workoutOngoingVM.dismissWorkoutTip()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.headline2())
                                    .foregroundColor(.label_700)
                            }
                        }
                        Spacer()
                        
                        Text(workoutOngoingVM.workoutModel.workoutTip)
                            .font(.body())
                            .foregroundColor(.label_900)
                        Spacer()
                        Spacer()
                    }
                    .padding()
                }
        }
    }
    
    @ViewBuilder
    var emptyFloatingButton: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
            .foregroundColor(.clear)
    }
}

struct WorkoutOngoingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutOngoingView(currentWorkoutNumber: 1)
            .onAppear {
                Font.registeFonts()
            }
    }
}
