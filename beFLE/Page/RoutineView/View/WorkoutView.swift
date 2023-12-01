//
//  WorkoutView.swift
//  beFLE
//
//  Created by 송재훈 on 11/25/23.
//

import SwiftUI

enum WorkoutViewStatus {
    case emptyView
    case editRoutineView
    case recordingWorkoutView
    case recordingRoutineView
    case editRecordingRoutineView
    case recordingFinishView
}

struct WorkoutView: View {
    let routineId: Int
    @Environment(\.dismiss) var dismiss: DismissAction
    @StateObject var vm = WorkoutViewModel()
    
    var body: some View {
        ZStack {
            switch vm.workoutViewStatus {
            case .emptyView:
                Empty
            case .editRoutineView:
                EditRoutineView()
            case .recordingWorkoutView:
                RecordingWorkout
            case .recordingRoutineView:
                RecordingRoutineView()
            case .editRecordingRoutineView:
                EditRecordingRoutineView()
            case .recordingFinishView:
                RecordingFinishView()
            }
        }
        //MARK: 제스처 기능 추가
        .environmentObject(vm)
    }
}


/// 초기 뷰
extension WorkoutView {
    @ViewBuilder
    var Empty: some View {
        LottieView()
            .navigationBarBackButtonHidden()
            .onAppear {
                vm.fetchRoutineId(routineId: routineId)
                vm.changeViewStatus(.editRoutineView)
            }
            .gesture(
                DragGesture().onChanged { value in
                    if value.startLocation.x < 50 {
                        vm.offset = value.translation.width
                    }
                }
                    .onEnded { value in
                        if value.predictedEndTranslation.width > 100 {
                            dismiss()
                        }
                        vm.offset = .zero
                    }
            )
            .offset(x: vm.offset)
            .animation(.easeInOut)
    }
}

/// 운동 기록 뷰
extension WorkoutView {
    var RecordingWorkout: some View {
        RecordingWorkoutView()
    }
}

#Preview {
    WorkoutView(routineId: 1)
}
