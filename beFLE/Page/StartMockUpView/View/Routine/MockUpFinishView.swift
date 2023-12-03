//
//  MockUpFinishView.swift
//  beFLE
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

struct MockUpFinishView: View {
    @Binding var elapsedTime: TimeInterval
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                Spacer()
                finishDate
                Spacer()
                finishImage
                Spacer()
                Spacer()
                showRecord
                showLogin
            }
            .padding(.bottom, 30)
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
    
    var finishDate: some View {
        VStack(spacing: 10) {
            Text("\(Date().format(.monthDay)) 운동 완료")
                .font(.title1())
                .foregroundColor(.label_900)
            Text("오늘도 고생 많으셨어요!")
                .font(.body())
                .foregroundColor(.label_700)
        }
        .frame(height: UIScreen.getHeight(80))
    }
    
    var finishImage: some View {
        Image("finishImage")
            .resizable()
            .scaledToFit()
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
                            Text("\(String(timeFormatted(elapsedTime)))")
                                .font(.title2())
                                .foregroundColor(.label_900)
                            Text("운동시간")
                                .font(.body2())
                                .foregroundColor(.label_700)
                        }
                        VStack(spacing: 3) {
                            Text("45kcal")
                                .font(.title2())
                                .foregroundColor(.label_900)
                            Text("소모칼로리")
                                .font(.body2())
                                .foregroundColor(.label_700)
                        }
                        VStack(spacing: 3) {
                            Text("360kg")
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
    
    var showRecord: some View {
        Button {
            MockUpMainViewModel.shared.changeToRecordTab()
            MockUpMainViewModel.shared.resetNavigationStack()
        } label: {
            FloatingButton(size: .medium, color: .green_main) {
                Text("기록 확인")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
            .padding(.bottom, 12)
        }
    }

    var showLogin: some View {
        Button {
            LaunchViewModel.shared.previewLogin()
        } label: {
            FloatingButton(size: .medium, color: .gray_600) {
                Text("로그인")
                    .foregroundColor(.green_main)
                    .font(.button1())
            }
            .padding(.bottom, 30)
        }
    }
    
    private func timeFormatted(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60
        return if hours >= 1 {
            String(format: "%01d시간%02d분", hours, minutes)
        } else {
            String(format: "%01d분", minutes)
        }
    }
}
