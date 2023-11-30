//
//  RecordingFinishView.swift
//  beFLE
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

struct RecordingFinishView: View {
    @StateObject var vm = RecordingFinishViewModel()
    @EnvironmentObject var workoutVM: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack(spacing: 10) {
                Spacer()
                Spacer()
                Spacer()
                FinishCard
                FinishImage
                Spacer()
                Spacer()
                NavigationButton
            }
            .padding(.bottom, 30)
        }
        .onAppear {
            vm.caculateWorkoutVolume(routineId: workoutVM.routineId)
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}

/// 완료 화면
extension RecordingFinishView {
    var FinishCard: some View {
        VStack(spacing: 5) {
            Text("\(Date().format(.monthDay)) 운동 완료")
                .font(.title1())
                .foregroundColor(.label_900)
            Text("오늘도 고생 많으셨어요!")
                .font(.body())
                .foregroundColor(.label_700)
        }
        .frame(height: UIScreen.getHeight(80))
    }
    
    var FinishImage: some View {
        LoadingImage(url: workoutVM.routineCompleteImageUrl)
            .frame(width: UIScreen.getWidth(318))
            .background {
                RoundedRectangle(cornerRadius: 8.0)
                    .frame(width: UIScreen.getWidth(318))
                    .foregroundColor(.gray_700)
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack(spacing: 40) {
                        VStack(spacing: 3) {
                            Text("\(vm.caculateWorkoutTime(elapsedTime: workoutVM.elapsedTime))")
                                .font(.title2())
                                .foregroundColor(.label_900)
                            Text("운동시간")
                                .font(.body2())
                                .foregroundColor(.label_700)
                        }
                        VStack(spacing: 3) {
                            // TODO: 칼로리 계산
                            Text("\(vm.totalCalories)Kcal")
                                .font(.title2())
                                .foregroundColor(.label_900)
                            Text("소모칼로리")
                                .font(.body2())
                                .foregroundColor(.label_700)
                        }
                        VStack(spacing: 3) {
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
    }
}

/// 네비게이션 버튼
extension RecordingFinishView {
    @ViewBuilder
    var NavigationButton: some View {
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
}

//#Preview {
//    RecordingFinishView()
//}

