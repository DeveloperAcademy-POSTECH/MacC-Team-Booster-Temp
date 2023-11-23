//
//  RecordingFinishView.swift
//  beFLE
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

struct RecordingFinishView: View {
    let routineId: Int
    @Binding var elapsedTime: TimeInterval
    @ObservedObject var recordViewModel: RecordingWorkoutViewModel
    var burnedKCalories: Int
    @StateObject var vm = RecordingFinishViewModel()
    @EnvironmentObject var editRoutineVM: EditRoutineViewModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var recordingWorkoutVM: RecordingWorkoutViewModel
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 10){
                    VStack(spacing: 5){
                        Text("\(vm.nowDateFormatter()) 운동 완료")
                            .font(.title1())
                            .foregroundColor(.label_900)
                        Text("오늘도 고생 많으셨어요!")
                            .font(.body())
                            .foregroundColor(.label_700)
                    }
                    .frame(height: UIScreen.getHeight(80))
                    .padding(.bottom, 40)
                    
                    Image("finishImage")
                        .resizable()
                        .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(318))
                        .background{
                            RoundedRectangle(cornerRadius: 8.0)
                                .frame(width: UIScreen.getWidth(318), height: UIScreen.getHeight(318))
                                .foregroundColor(.gray_700)
                        }
                        .overlay{
                            VStack{
                                Spacer()
                                HStack(spacing: 40){
                                    VStack(spacing: 3){
                                        Text(String(recordViewModel.finishTimeFormatted(elapsedTime)))
                                            .font(.title2())
                                            .foregroundColor(.label_900)
                                        Text("운동시간")
                                            .font(.body2())
                                            .foregroundColor(.label_700)
                                    }
                                    VStack(spacing: 3){
                                        Text("\(burnedKCalories)kcal")
                                            .font(.title2())
                                            .foregroundColor(.label_900)
                                        Text("소모칼로리")
                                            .font(.body2())
                                            .foregroundColor(.label_700)
                                    }
                                    VStack(spacing: 3){
                                        Text("\(vm.volume)kg")
                                            .font(.title2())
                                            .foregroundColor(.label_900)
                                        Text("총 볼륨")
                                            .font(.body2())
                                            .foregroundColor(.label_700)
                                    }
                                }
                            }
                            .padding(.bottom, 30)
                        }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Button {
                        MainViewModel.shared.changeToRecordTab()
                        MainViewModel.shared.resetNavigationStack()
                    } label: {
                        FloatingButton(size: .medium, color: .green_main) {
                            Text("기록 확인")
                                .foregroundColor(.gray_900)
                                .font(.button1())
                        }
                        .padding(.bottom, 12)
                    }
                    
                    Button {
                        MainViewModel.shared.resetNavigationStack()
                    } label: {
                        FloatingButton(size: .medium, color: .gray_600) {
                            Text("닫기")
                                .foregroundColor(.green_main)
                                .font(.button1())
                        }
                        .padding(.bottom, 30)
                    }
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            vm.caculateWorkoutVolume(routineId: routineId)
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

//#Preview {
//    RecordingFinishView()
//}

