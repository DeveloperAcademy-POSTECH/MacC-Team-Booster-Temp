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
        workoutModel = MockUpWorkoutModel(workoutDate: "10월 5일(일)", influencerName: "정회승", workoutName: "클로즈 그립 랫 풀 다운", workoutSet: 4, workoutKgs: [nil, nil, nil, nil], workoutReps: [10, 10, 15, 15], alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"], relatedContentURL: [ "http://www.youtube.com"], workoutTip: "고정축이 흔들리면 정확한 타겟이 불가능하기 때문에 꼭! 랫 풀 다운 할 때는 발꿈치를 들어서 무릎 패드와 다리 사이에 공간이 없도록 단단한 지지대를 만들어 주는 것이 굉장히 중요합니다.")
        
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
