//
//  MockUpWorkoutOngoingView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

struct MockUpWorkoutOngoingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = MockUpStopwatchViewModel()
    @FocusState private var isFocused: Bool
    @Binding var tabSelection: Int
    
//    let currentWorkoutNumber: Int
//    @ObservedObject var routineVM: RoutineVM
    @StateObject var workoutOngoingVM = MockUpWorkoutOngoingViewModel()
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
            
            ScrollView {
                VStack{
                    workoutInfomation
                    ImageTip(currentIndex: $currentIndex, workoutOngoingVM: MockUpWorkoutOngoingViewModel())
                    Spacer()
                    WorkoutSetButton
                    WorkoutSetList
                    //                    RelatedContent
                    EmptyFloatingButton
                }
                }
            
            VStack {
                Spacer()
                isFocused ? nil : WorkoutButton
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
                // MARK: 취소
                dismiss()
            }
            Button("취소") {
                // MARK: 완료하기
//                routineVM.showWorkOutOnGoing.toggle()
            }
        }
        //TODO: 운동 완료 후 창닫기 (수행하지 않지 않은 운동이 있을 때만)
        .alert("운동을 완료하시겠습니까?", isPresented: $workoutOngoingVM.isWorkoutFinishAlertShow) {
            Button("취소") {
                // MARK: 취소
                dismiss()
            }
            NavigationLink("완료하기") {
                // MARK: 완료하기
                MockUpFinishView(tabSelection: $tabSelection)
            }
        }
        .sheet(isPresented: $isPauseShow) {
            MockUpPauseSheet(viewModel: viewModel)
        }
        .onAppear{
            viewModel.Start()
        }
        .onTapGesture {
                    isFocused = false
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
        .padding(.horizontal)
        .padding(.vertical)
    }
    
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
    
    var WorkoutButton: some View {
        RoundedRectangle(cornerRadius: 100)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(76))
            .foregroundColor(.gray_600)
            .overlay {
                HStack {
                    Spacer()
                    
                    Button {
                        workoutOngoingVM.controlRepetition()
                    } label: {
                        if workoutOngoingVM.workoutSet.count == workoutOngoingVM.currentSet {
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
    
    
    
    var EmptyFloatingButton: some View {
        FloatingButton(backgroundColor: .clear) { }
    }
    
    
}

struct MockUpWorkoutSetCard: View {
    @Binding var workoutSet: WorkoutSetModel
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
            
            if workoutSet.isFinish {
                CheckButton()
            }
            else {
                EmptyCheckButton()
            }
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
                            Spacer()
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

#Preview {
    NavigationStack{
        MockUpWorkoutOngoingView(viewModel: MockUpStopwatchViewModel(), tabSelection: .constant(3))
    }
}
