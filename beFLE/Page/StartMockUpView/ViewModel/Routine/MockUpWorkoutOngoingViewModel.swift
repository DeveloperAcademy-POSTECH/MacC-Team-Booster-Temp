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
        workoutModel = MockUpWorkoutModel(workoutDate: "12월 4일(월)", influencerName: "정회승", workoutName: "이지바 바이셉스 컬", workoutSet: 3, workoutKgs: [nil, nil, nil], workoutReps: [10, 10, 8], alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"], relatedContentURL: [ "https://www.youtube.com/embed/xYQQSaeRVlQ?si=7ZuPXSFKN_uv965D&amp;start=996"], workoutTip: "이지바로 수축에 집중해서 수축 지점에서 잠시 정지해서 펌핑을 극대화해주세요.\n오버 그립으로 수행 할 수 있다면 수행해 보세요.")
        
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
