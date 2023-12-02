//
//  MockUpWorkoutOngoingView.swift
//  beFLE
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

struct MockUpWorkoutOngoingView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = MockUpStopwatchViewModel()
    @FocusState private var isFocused: Bool
    @StateObject var workoutOngoingVM = MockUpWorkoutOngoingViewModel()
    @State var isPauseShow = false
    //    @State var isFinishShow = false
    @State var isAlternativeShow = false
    @State var isAlternativeWorkoutShow = false
    @State private var currentIndex = 0
    @State var isDeleteAlertShow: Bool = false
    @State var exitAlertShow: Bool = false
    @State var existUnfinished: Bool = false
    @Namespace var topID
    @State var showFinishView = false
    let workoutName = "클로즈 그립 랫 풀 다운"
    
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            ScrollViewReader { proxy in
                ScrollView {
                    ZStack{
                        VStack{
                            workoutInfomation
                            ImageTip(currentIndex: $currentIndex, workoutOngoingVM: MockUpWorkoutOngoingViewModel())
                            Spacer()
                            WorkoutSetButton
                            WorkoutSetList
                            FloatingButton(size: .medium) {}
                                .padding(.bottom, 40)
                                .id(topID)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .overlay(alignment: .bottom) {
                    bottomGradientView(proxy: proxy)
                    workoutButton(proxy: proxy)
                }
            }
        }
        .navigationBarTitle("",displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
            ToolbarItem(placement: .principal) {
                NavigationTitle
            }
        }
        .navigationBarBackButtonHidden()
        .confirmationDialog(workoutName, isPresented: $isAlternativeShow, titleVisibility: .visible) {
            AlternativeActionSheet
        }
        .alert("운동을 중단하시겠습니까?", isPresented: $exitAlertShow) {
            Button("운동중단") {
                dismiss()
            }
            Button("취소") { }
        }
        .alert("운동을 완료하시겠습니까?", isPresented: $workoutOngoingVM.isWorkoutFinishAlertShow) {
            Button("취소") {
                // MARK: 취소
            }
            Button("완료하기") {
                // MARK: 완료하기
                //                MockUpFinishView(elapsedTime: $viewModel.elapsedTime, tabSelection: $tabSelection)
                showFinishView = true
            }
        }
        .fullScreenCover(isPresented: $showFinishView){
            MockUpFinishView(elapsedTime: $viewModel.elapsedTime)
        }
        .sheet(isPresented: $isPauseShow) {
            MockUpPauseSheet(viewModel: viewModel)
        }
        .onAppear {
            viewModel.Start()
            viewModel.elapsedTime += viewModel.bgTimer()
        }
        .onDisappear {
            viewModel.Stop()
        }
        .onTapGesture {
            isFocused = false
        }
    }
    
    func bottomGradientView(proxy: ScrollViewProxy) -> some View {
        VStack {
            Spacer()
            isFocused ? nil :
            LinearGradient(colors: [.clear, .gray_900.opacity(0.7), .gray_900, .gray_900, .gray_900], startPoint: .top, endPoint: .bottom)
                .frame(height: UIScreen.getHeight(150), alignment: .bottom)
                .allowsHitTesting(false)
        }
        .ignoresSafeArea()
    }
    
    func workoutButton(proxy: ScrollViewProxy) -> some View {
        VStack {
            Spacer()
            isFocused ? nil :
            FloatingButton(size: .large, color: .gray_700) {
                HStack {
                    Spacer()
                    
                    Button {
                        if workoutOngoingVM.currentSet >= 1 {
                            withAnimation {
                                proxy.scrollTo(topID)
                            }
                        }
                        workoutOngoingVM.controlRepetition()
                    } label: {
                        if workoutOngoingVM.workoutSet.count == workoutOngoingVM.currentSet {
                            FloatingButton(size: .small, color: .red_main) {
                                Text("운동 완료")
                                    .font(.button1())
                                    .foregroundColor(.label_900)
                            }
                        }
                        else {
                            FloatingButton(size: .small, color: .green_main) {
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
                .padding(.trailing, 8)
            }
        }
    }
    
    
    var BackButton: some View {
        Button {
            exitAlertShow = true
        } label: {
            Image(systemName: "xmark")
                .foregroundColor(.label_700)
                .font(.headline2())
        }
    }
    
    @ViewBuilder
    var NavigationTitle: some View {
        HStack (spacing: 0) {
            Image(systemName: "flame.fill")
                .foregroundColor(.green_main)
                .font(.footnote)
            Text(timeFormatted(viewModel.elapsedTime))
                .font(.headline1())
                .foregroundColor(.label_900)
                .padding(.horizontal, 10)
            Circle()
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(28), height: UIScreen.getHeight(28))
                .overlay {
                    Image(systemName: "pause.fill")
                        .font(.caption())
                        .scaleEffect(0.8)
                        .foregroundColor(.label_900)
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
        return String(format: "%01d:%02d:%02d",hours, minutes, seconds)
    }
    
    @ViewBuilder
    var AlternativeActionSheet: some View {
        Button {
            isAlternativeWorkoutShow = true
        } label: {
            Text("운동 대체")
        }
        
        Button {
            isDeleteAlertShow = true
        } label: {
            Text("삭제")
        }
        
        
        Button(role: .cancel) {
        } label: {
            Text("취소")
        }
    }
    
    
    var workoutInfomation: some View {
        VStack {
            HStack {
                Text("1 / 10")
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
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    var WorkoutImage: some View {
        Image("tempWorkoutImage")
            .resizable()
        //            .scaledToFit()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
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
        .padding()
    }
    
    @ViewBuilder
    var WorkoutSetList: some View {
        ForEach($workoutOngoingVM.workoutSet) { $workoutSet in
            MockUpWorkoutSetCard(workoutSet: $workoutSet, isFocused: $isFocused)
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
}

struct MockUpWorkoutSetCard: View {
    @Binding var workoutSet: MockUpWorkoutSetModel
    var isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            Text("\(workoutSet.index)")
                .foregroundColor(.label_900)
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("자율", value: $workoutSet.kg, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_500)
                        .multilineTextAlignment(.trailing)
                    
                        .padding(.trailing)
                }
            Text("kg")
                .foregroundColor(.label_700)
            Spacer()
            
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                .foregroundColor(.gray_700)
                .overlay {
                    TextField("", value: $workoutSet.repetition, format: .number)
                        .focused(isFocused)
                        .keyboardType(.numberPad)
                        .foregroundColor(.label_900)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing)
                }
            Text("회")
                .foregroundColor(.label_700)
            Spacer()
            
            CheckButton(status: workoutSet.isFinish ? .check : .empty)
        }
        .font(.body())
        .padding(.horizontal)
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct ImageTip: View {
    @Binding var currentIndex: Int
    @ObservedObject var workoutOngoingVM: MockUpWorkoutOngoingViewModel
    
    var body: some View {
        TabView(selection: $currentIndex){
            VStack {
                ZStack{
                    WorkoutImage
                    Button{
                        withAnimation{
                            currentIndex = 1
                        }
                    } label: {
                        VStack{
                            WorkoutTipButton
                        }
                    }
                }
                Spacer()
                    .frame(height: UIScreen.getHeight(50))
            }
            .tag(0)
            VStack{
                WorkoutTip
                Spacer()
                    .frame(height: UIScreen.getHeight(50))
            }
            .tag(1)
            
        }
        .frame(height: UIScreen.getHeight(270))
        .tabViewStyle(.page)
    }
    
    var WorkoutImage: some View {
        Image("tempWorkoutImage")
            .resizable()
            .scaledToFit()
            .frame(height: UIScreen.getHeight(220))
    }
    
    var WorkoutTip: some View {
        RoundedRectangle(cornerRadius: 8.0)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(220))
            .foregroundColor(.gray_800)
            .overlay {
                VStack {
                    HStack {
                        Image("descriptionFace1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.getWidth(48), height: UIScreen.getHeight(48))
                            .padding(.horizontal, 5)
                            .padding(.top, 4)
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    
                    Text(workoutOngoingVM.workoutModel.workoutTip)
                        .font(.body())
                        .foregroundColor(.label_900)
                        .padding(.horizontal, 1.9)
                        .lineSpacing(6.0)
                    Spacer()
                    Spacer()
                }
                .padding()
            }
            .padding(.top)
    }
    
    @ViewBuilder
    var WorkoutTipButton: some View {
        HStack {
            Spacer()
            Image(systemName: "chevron.backward")
                .font(.button2())
                .foregroundColor(.label_500)
            RoundedShape(corners: [.topLeft, .bottomLeft])
                .frame(width: UIScreen.getWidth(43), height: UIScreen.getHeight(68))
                .foregroundColor(.fill_1)
                .overlay {
                    HStack {
                        Text("팁")
                            .font(.button2())
                            .foregroundColor(.green_main)
                    }
                    .padding(.horizontal)
                }
        }
    }
}
//
//#Preview {
//    NavigationStack{
//        MockUpWorkoutOngoingView(viewModel: MockUpStopwatchViewModel(), tabSelection: .constant(3))
//    }
//}
