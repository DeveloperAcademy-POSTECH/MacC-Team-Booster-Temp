//
//  MockUpPauseSheet.swift
//  beFLE
//
//  Created by 정회승 on 11/14/23.
//

import SwiftUI

struct MockUpPauseSheet: View {
    @ObservedObject var viewModel: MockUpStopwatchViewModel
    @StateObject var pauseViewModel = MockUpPauseStopwatchViewModel()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            timeButton
        }
        .onAppear{
            pauseViewModel.Start()
        }
        .onDisappear{
            pauseViewModel.reset()
            viewModel.Start()
        }
        .presentationDetents([.height(UIScreen.getHeight(378))])
    }
    
    private func timeFormatted(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var timeButton: some View {
        VStack {
            Text("운동 정지")
                .font(.headline1())
                .foregroundColor(.label_700)
            Text(timeFormatted(pauseViewModel.elapsedTime))
                .font(.largeTitle())
                .foregroundColor(.label_900)
            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 100)
                    .foregroundColor(.green_main)
                    .frame(width: UIScreen.getWidth(132), height: UIScreen.getHeight(60))
                    .overlay {
                        HStack {
                            Text("다시 시작")
                            Image(systemName: "play.fill")
                        }
                        .font(.button1())
                        .foregroundColor(.gray_900)
                    }
            }
        }
    }
}

#Preview {
    MockUpPauseSheet(viewModel: MockUpStopwatchViewModel())
}
