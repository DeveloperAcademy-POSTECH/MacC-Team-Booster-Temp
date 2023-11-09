//
//  WorkoutOngoingView.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

struct WorkoutOngoingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let currentWorkoutNumber: Int
    @ObservedObject var routineVM: RoutineViewModel
    @StateObject var workoutOngoingVM = WorkoutOngoingViewModel()
    @State var isPauseShow = false
    @State var isFinishShow = false
    @State var isAlternativeShow = false
    
    let workoutName = "클로즈 그립 랫 풀 다운"
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Spacer()
                    Spacer()
                    workoutInfomation
                    ZStack {
                        WorkoutImage
                        WorkoutTipButton
                    }
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
            
            ToolbarItem(placement: .principal) {
                NavigationTitle
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                EditButton
            }
        }
        .navigationBarBackButtonHidden()
        .confirmationDialog(workoutName, isPresented: $isAlternativeShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        //        .sheet(isPresented: $workoutOngoingVM.isAlternativeWorkoutShow) {
        //            alternativeWorkoutSheet
        //        }
        .alert("운동을 중단하시겠습니까?", isPresented: $isFinishShow) {
            Button("운동중단") {
                // MARK: 취소
            }
            Button("취소") {
                // MARK: 완료하기
                routineVM.showWorkOutOnGoing.toggle()
            }
        }
//        .alert("운동을 완료할까요?", isPresented: $workoutOngoingVM.isWorkoutFinishAlertShow) {
        .alert("운동을 완료할까요?", isPresented: .constant(true)) {
            Button("취소") {
                // MARK: 취소
            }
            Button("완료하기") {
                // MARK: 완료하기
                routineVM.showWorkOutOnGoing.toggle()
            }
        }
        .sheet(isPresented: $isPauseShow) {
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
            Text("00:00:00")
                .foregroundColor(.label_900)
                .font(.headline1())
            Circle()
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(28), height: UIScreen.getHeight(28))
                .overlay {
                    Image(systemName: "pause.fill")
                        .resizable()
                        .foregroundColor(.label_900)
                        .frame(width: UIScreen.getWidth(11), height: UIScreen.getHeight(14))
                }
                .onTapGesture {
                    isPauseShow = true
                }
        }
    }
    
    var EditButton: some View {
        Button {
            isAlternativeShow = true
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            // TODO: .
            isAlternativeShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            // TODO: .
            //            isDeleteAlertShow = true
        } label: {
            Text("삭제")
        }
        
        Button(role: .cancel) {
            // TODO: .
        } label: {
            Text("취소")
        }
    }
    
    var workoutInfomation: some View {
        VStack {
            HStack {
                Text("3 / 10")
                    .foregroundColor(.label_700)
                Text("|")
                    .foregroundColor(.label_400)
                Text("등")
                    .foregroundColor(.label_700)
                Spacer()
            }
            .font(.body2())
            
            Spacer()
            
            HStack {
//                Text(workoutOngoingVM.workoutModel.workoutName)
                Text("운동 명")
                    .font(.title1())
                    .foregroundColor(.label_900)
                
                //                Button {
                //                    workoutOngoingVM.showAlternativeWorkout()
                //                } label: {
                //                    RoundedRectangle(cornerRadius: 4)
                //                        .frame(width: UIScreen.getWidth(52), height: UIScreen.getHeight(28))
                //                        .foregroundColor(.gray_700)
                //                        .overlay {
                //                            HStack(spacing: 4) {
                //                                Image(systemName: "arrow.2.squarepath")
                //                                Text("대체")
                //                            }
                //                            .font(.caption())
                //                            .foregroundColor(.label_700)
                //                        }
                //                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    var WorkoutImage: some View {
        Image("tempWorkoutImage")
            .resizable()
        //            .scaledToFit()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
            .foregroundColor(.gray_600)
            .padding(.horizontal)
    }
    
    var WorkoutSetButton: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(106), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    HStack {
                        Button {
//                            workoutOngoingVM.decreaseWorkoutSet()
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
                        
//                        Text("\(workoutOngoingVM.workoutSet.count)세트")
                        Text("세트")
                            .foregroundColor(.label_700)
                        
                        Button {
//                            workoutOngoingVM.increaseWorkoutSet()
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
        .padding(.horizontal)
        .padding(.vertical)
    }
    
    var WorkoutSetList: some View {
        WorkoutSetCard(workoutSet: .constant(WorkoutSetModel(index: 0, repetition: 5, isFinish: false)))
//        ForEach($workoutOngoingVM.workoutSet) { $workoutSet in
//            WorkoutSetCard(workoutSet: $workoutSet)
//                .overlay {
//                    if workoutSet.index == workoutOngoingVM.currentSet {
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(lineWidth: 1)
//                            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(52))
//                            .foregroundColor(.green_main)
//                    }
//                }
//        }
    }
    
    var WorkoutButton: some View {
        FloatingButton(backgroundColor: .gray_600) {
            HStack {
                NavigationLink {
                    WorkoutStatusView()
                } label: {
                    Image(systemName: "list.bullet")
                        .foregroundColor(.green_main)
                }
                
                Spacer()
                
                Button {
//                    workoutOngoingVM.controlRepetition()
                } label: {
//                    if workoutOngoingVM.workoutSet.count == workoutOngoingVM.currentSet {
                    if true {
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
                                Text("다음 세트 >")
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
    
    
    var RelatedContent: some View {
        VStack {
            HStack {
                Text("관련 영상")
                    .font(.title2())
                    .foregroundColor(.label_900)
                Spacer()
            }
            
            ScrollView(.horizontal) {
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
    
    @ViewBuilder
    var WorkoutTipButton: some View {
//        if !workoutOngoingVM.isWorkoutTipShow {
        if true {
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
//                workoutOngoingVM.showWorkoutTip()
            }
        }
        else {
            RoundedRectangle(cornerRadius: 7.2)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
                .foregroundColor(.gray_800)
                .overlay {
                    VStack {
                        HStack {
//                            Text("\(workoutOngoingVM.workoutModel.influencerName)'s Tip")
                            Text("인플루언서's Tip")
                                .font(.headline2())
                                .foregroundColor(.label_700)
                            Spacer()
                            Button {
//                                workoutOngoingVM.dismissWorkoutTip()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.headline2())
                                    .foregroundColor(.label_700)
                            }
                        }
                        Spacer()
                        
//                        Text(workoutOngoingVM.workoutModel.workoutTip)
                        Text("팁")
                            .font(.body())
                            .foregroundColor(.label_900)
                        Spacer()
                        Spacer()
                    }
                    .padding()
                }
        }
    }
    
    var EmptyFloatingButton: some View {
        FloatingButton(backgroundColor: .clear) { }
    }
}

struct WorkoutOngoingView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutOngoingView(currentWorkoutNumber: 1, routineVM: RoutineViewModel())
    }
}
