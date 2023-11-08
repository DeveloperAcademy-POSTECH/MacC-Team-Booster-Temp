//
//  WorkoutOngoingVM.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/20.
//

import SwiftUI

class WorkoutOngoingVM: ObservableObject {
    let workoutModel: WorkoutModel
    @Published var isRoutineSequenceShow = false
    @Published var isAlternativeWorkoutShow = false
    @Published var isWorkoutFinishAlertShow = false
    @Published var isWorkoutTipShow = false
    @Published var workoutSet: [WorkoutSetModel] = []
    @Published var currentSet = 1
    
    init() {
        workoutModel = WorkoutModel(workoutDate: "10월 5일(일)", influencerName: "정회승", workoutName: "클로즈 그립 랫 풀 다운", workoutSet: 4, workoutKgs: [0, 0, 0, 0], workoutReps: [10, 10, 15, 15], alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"], relatedContentURL: [ "http://www.youtube.com"], workoutTip: "고정축이 흔들리면 정확한 타겟이 불가능하기 때문에 꼭! 랫 풀 다운 할 때는 발꿈치를 들어서 무릎 패드와 다리 사이에 공간이 없도록 단단한 지지대를 만들어 주는 것이 굉장히 중요합니다.")
        
        for i in 0..<workoutModel.workoutSet {
            workoutSet.append(WorkoutSetModel(index: i + 1, kg: workoutModel.workoutKgs[i], repetition: workoutModel.workoutReps[i], isFinish: false))
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
            workoutSet.append(WorkoutSetModel(index: workoutSet.count + 1, kg: 0, repetition: 0, isFinish: false))
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
