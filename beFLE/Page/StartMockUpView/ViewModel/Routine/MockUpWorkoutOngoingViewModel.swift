//
//  MockUpWorkoutOngoingViewModel.swift
//  beFLE
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

struct MockUpWorkoutModel {
    var workoutDate: String
    var influencerName: String
    var workoutName: String
    var workoutSet: Int
    var workoutKgs: [Int?]
    var workoutReps: [Int]
    var alternativeWorkout: [String]
    var relatedContentURL: [String]
    var workoutTip: String
}

struct MockUpWorkoutSetModel: Identifiable {
    var id = UUID()
    
    var index: Int
    var kg: Int?
    var repetition: Int
    var isFinish: Bool
}

class MockUpWorkoutOngoingViewModel: ObservableObject {
    let workoutModel: MockUpWorkoutModel
    @Published var isRoutineSequenceShow = false
    @Published var isAlternativeWorkoutShow = false
    @Published var isWorkoutFinishAlertShow = false
    @Published var isWorkoutTipShow = false
    @Published var workoutSet: [MockUpWorkoutSetModel] = []
    @Published var currentSet = 1
    
    init() {
        workoutModel = MockUpWorkoutModel(workoutDate: "12월 4일(월)", influencerName: "정회승", workoutName: "사이드 레터럴 레이즈", workoutSet: 3, workoutKgs: [nil, nil, nil], workoutReps: [20, 20, 25], alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"], relatedContentURL: ["https://www.youtube.com/embed/iNgwwI3WBTo?si=Xf875Rpsjktj0Skc&amp;start=110"], workoutTip: "상위구간에서 0.5초간 정지했다가 내려가는 느낌으로 운동해주세요.\n손의 새끼손가락 방향이 엄지 방향보다 더 위에 있게 해주세요.\n중량보다는 자극에 집중해 주세요.")
        
        for i in 0..<workoutModel.workoutSet {
            workoutSet.append(MockUpWorkoutSetModel(index: i + 1, kg: workoutModel.workoutKgs[i], repetition: workoutModel.workoutReps[i], isFinish: false))
        }
    }
    
    func decreaseWorkoutSet() {
        if workoutSet.count > 1 {
            if workoutSet.count == currentSet {
                currentSet -= 1
            }
            workoutSet.removeLast()
        }
    }
    
    func increaseWorkoutSet() {
        if workoutSet.count < 10 {
            workoutSet.append(MockUpWorkoutSetModel(index: workoutSet.count + 1, kg: 0, repetition: 0, isFinish: false))
        }
    }
    
    func controlRepetition() {
        if workoutSet.count == currentSet {
            workoutSet[currentSet - 1].isFinish = true
            showWorkoutFinishAlert()
        }
        else {
            workoutSet[currentSet - 1].isFinish = true
            currentSet += 1
        }
    }
    
    func showAlternativeWorkout() {
        isAlternativeWorkoutShow = true
    }
    
    func dismissAlternativeWorkOut() {
        isAlternativeWorkoutShow = false
    }
    
    func showWorkoutFinishAlert() {
        isWorkoutFinishAlertShow = true
    }
    
    func showRoutineSequenceShow() {
        isRoutineSequenceShow = true
    }
    
    func dismissRoutineSequenceShow() {
        isRoutineSequenceShow = false
    }
    
    func showWorkoutTip() {
        isWorkoutTipShow = true
    }
    
    func dismissWorkoutTip() {
        isWorkoutTipShow = false
    }
}
