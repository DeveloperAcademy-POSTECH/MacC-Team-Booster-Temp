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
            
            pauseButton
        }
        .onAppear{
            pauseViewModel.Start()
            pauseViewModel.elapsedTime = pauseViewModel.elapsedTime + pauseViewModel.bgTimer()
        }
        .onDisappear{
            pauseViewModel.reset()
            viewModel.Start()
        }
        .presentationDetents([.height(UIScreen.getHeight(378))])
    }
    
    var pauseButton: some View {
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
                FloatingButton(size: .semiSmall, color: .green_main) {
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
    
    private func timeFormatted(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    MockUpPauseSheet(viewModel: MockUpStopwatchViewModel())
}
