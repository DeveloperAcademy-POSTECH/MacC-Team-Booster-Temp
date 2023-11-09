//
//  WorkoutOngoing.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

struct WorkoutOngoingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = StopwatchVM()
    
    let currentWorkoutNumber: Int
    @ObservedObject var routineVM: RoutineVM
    @StateObject var workoutOngoingVM = WorkoutOngoingVM()
    @State var isPauseShow = false
//    @State var isFinishShow = false
    @State var isAlternativeShow = false
    @State var isAlternativeWorkoutShow = false
    @State private var currentIndex = 0
    @State var isDeleteAlertShow: Bool = false
    @State var exitAlertShow: Bool = false
    @State var existUnfinished: Bool = false
    
    let workoutName = "클로즈 그립 랫 풀 다운"
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Spacer()
                    Spacer()
                    workoutInfomation
                    ImageTip(currentIndex: $currentIndex)
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
        .sheet(isPresented: $isAlternativeWorkoutShow) {
            AlternativeWorkoutSheet()
        }
        .alert("운동을 중단하시겠습니까?", isPresented: $exitAlertShow) {
            Button("운동중단") {
                // MARK: 취소
            }
            Button("취소") {
                // MARK: 완료하기
                routineVM.showWorkOutOnGoing.toggle()
            }
        }
        //운동 완료 후 창닫기
        .alert("운동을 완료할까요?", isPresented: $workoutOngoingVM.isWorkoutFinishAlertShow) {
            Button("취소") {
                // MARK: 취소
            }
            NavigationLink("완료하기") {
                // MARK: 완료하기
                WorkoutFinishView()
            }
        }
        .alert(isPresented: $isDeleteAlertShow) {
            Alert(
                title: Text("운동을 삭제하시겠습니까?"),
                message: Text(""),
                primaryButton: .destructive(Text("삭제"),
                                            action: {
                                                
                                            }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        .alert(isPresented: $isDeleteAlertShow) {
            Alert(
                title: Text("운동을 삭제하시겠습니까?"),
                message: Text(""),
                primaryButton: .destructive(Text("삭제"),
                                            action: {
                                                
                                            }),
                secondaryButton: .cancel(Text("취소"))
            )
        }
        //MARK: 운동 완료는 했지만 운동이 존재할 경우
        .alert(isPresented: $existUnfinished) {
            Alert(
                title: Text("완료하지 않은 운동이 있습니다/n해당 운동을 확인하시겠습니까?"),
                message: Text(""),
                primaryButton: .destructive(Text("운동완료"),
                                            action: {
                                                
                                            }),
                secondaryButton: .destructive(Text("확인"),
                                              action: {
                                                  
                                              })
            )
        }
        .sheet(isPresented: $isPauseShow) {
            PauseSheet(viewModel: viewModel)
        }
        .onAppear{
            viewModel.Start()
        }
    }
    
    
    var BackButton: some View {
        Button {
            exitAlertShow = true
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    @ViewBuilder
    var NavigationTitle: some View {
        HStack {
            Image(systemName: "flame.fill")
                .foregroundColor(.label_700)
                .font(.headline2())
            Text(timeFormatted(viewModel.elapsedTime))
                .font(.headline1())
                .foregroundColor(.label_900)
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
                    viewModel.Stop()
                }
        }
    }
    
    private func timeFormatted(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
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
            isAlternativeWorkoutShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            // TODO: .
            isDeleteAlertShow = true
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
                Text(workoutOngoingVM.workoutModel.workoutName)
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
                            workoutOngoingVM.decreaseWorkoutSet()
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
                        
                        Text("\(workoutOngoingVM.workoutSet.count)세트")
                            .foregroundColor(.label_700)
                        
                        Button {
                            workoutOngoingVM.increaseWorkoutSet()
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
                                .frame(width: UIScreen.getWidth(132), height: UIScreen.getHeight(60))
                                .foregroundColor(.green_main)
                                .overlay {
                                    HStack{
                                        Text("다음 세트")
                                            .font(.button1())
                                            .foregroundColor(.gray_900)
                                        Image(systemName: "chevron.right")
                                            .font(.button2())
                                            .foregroundColor(.gray_900)
                                    }
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
                ForEach(workoutOngoingVM.workoutModel.relatedContentURL.indices) { index in
                    HStack{
                        RelatedContentCard(videoNum: 1, contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                        RelatedContentCard(videoNum: 1, contentURL: workoutOngoingVM.workoutModel.relatedContentURL[index])
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    var EmptyFloatingButton: some View {
        FloatingButton(backgroundColor: .clear) { }
    }
    
    
}

struct ImageTip: View {
    @Binding var currentIndex: Int
    @StateObject var workoutOngoingVM = WorkoutOngoingVM()
    
    var body: some View {
        TabView(selection: $currentIndex){
            
            ZStack{
                WorkoutImage
                Button{
                    withAnimation{
                        currentIndex = 1
                    }
                } label: {
                    WorkoutTipButton
                }
            }
            .tag(0)
            
            WorkoutTip
                .tag(1)
            
        }
        .frame(height: UIScreen.getHeight(300))
        .tabViewStyle(.page)
    }
    
    var WorkoutImage: some View {
        Image("tempWorkoutImage")
            .resizable()
        //            .scaledToFit()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(230))
            .foregroundColor(.gray_600)
            .padding(.horizontal)
    }
    
    var WorkoutTip: some View {
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
    
    @ViewBuilder
    var WorkoutTipButton: some View {
        HStack {
            Spacer()
            Image(systemName: "chevron.backward")
                .font(.button2())
                .foregroundColor(.label_500)
            RoundedRectangle(cornerRadius: 8.0)
                .frame(width: UIScreen.getWidth(80), height: UIScreen.getHeight(68))
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
        .offset(x: UIScreen.getWidth(30))
        //            .onTapGesture {
        //                workoutOngoingVM.showWorkoutTip()
        //            }
    }
}

struct WorkoutOngoingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            WorkoutOngoingView(viewModel: StopwatchVM(), currentWorkoutNumber: 1, routineVM: RoutineVM())
        }
    }
}
