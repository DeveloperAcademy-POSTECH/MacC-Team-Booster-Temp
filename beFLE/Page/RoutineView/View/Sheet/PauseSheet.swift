//
//  PauseSheet.swift
//  beFLE
//
//  Created by 송재훈 on 11/5/23.
//

import SwiftUI

struct PauseSheet: View {
    @EnvironmentObject var workoutVM: WorkoutViewModel
    @StateObject var vm = PauseStopwatchVM()
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_800.ignoresSafeArea()
            
            VStack {
                Text("운동 일시정지")
                    .font(.headline1())
                    .foregroundColor(.label_700)
                Text(timeFormatted(vm.elapsedTime))
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
        .onAppear {
            vm.timerStart()
            vm.elapsedTime = vm.elapsedTime + vm.bgTimer()
        }
        .onDisappear {
            vm.reset()
            workoutVM.timerStart()
        }
        .presentationDetents([.height(UIScreen.getHeight(378))])
    }
    
    private func timeFormatted(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//struct PauseSheet_Preview: PreviewProvider {
//    static var previews: some View {
//        PauseSheet(viewModel: StopwatchVM())
//    }
//}
