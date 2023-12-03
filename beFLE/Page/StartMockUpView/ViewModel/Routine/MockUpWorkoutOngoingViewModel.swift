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
    @Published var isRoutineSequenceShow = false
    @Published var isAlternativeWorkoutShow = false
    @Published var isWorkoutFinishAlertShow = false
    @Published var isWorkoutTipShow = false
    @Published var workoutSet: [MockUpWorkoutSetModel] = []
    @Published var currentSet = 1
    
    let workoutModel = [
        MockUpWorkoutModel(
            workoutDate: "12월 4일(월)",
            influencerName: "정회승",
            workoutName: "이지바 바이셉스 컬",
            workoutSet: 3,
            workoutKgs: [nil, nil, nil],
            workoutReps: [10, 10, 8],
            alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"],
            relatedContentURL: [ "https://www.youtube.com/embed/xYQQSaeRVlQ?si=7ZuPXSFKN_uv965D&amp;start=996"],
            workoutTip: "이지바로 수축에 집중해서 수축 지점에서 잠시 정지해서 펌핑을 극대화해주세요.\n오버 그립으로 수행 할 수 있다면 수행해 보세요."
        ),
        MockUpWorkoutModel(
            workoutDate: "12월 4일(월)",
            influencerName: "정회승",
            workoutName: "이지바 오버 헤드 익스텐션",
            workoutSet: 2,
            workoutKgs: [nil, nil],
            workoutReps: [10, 10],
            alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"],
            relatedContentURL: ["https://www.youtube.com/embed/xYQQSaeRVlQ?si=7ZuPXSFKN_uv965D&amp;start=996"],
            workoutTip: "이두가 머리를 스치듯 수축해 보세요.\n최대한 주먹을 높게까지 밀어보세요.\n최대한 근육을 무게로 많이 늘려보세요."
        ),
        MockUpWorkoutModel(
            workoutDate: "12월 4일(월)",
            influencerName: "정회승",
            workoutName: "업 라이트 로우",
            workoutSet: 3,
            workoutKgs: [nil, nil, nil],
            workoutReps: [15, 10, 10],
            alternativeWorkout: ["클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운", "클로즈 그립 랫 풀 다운"],
            relatedContentURL: [ "https://www.youtube.com/embed/fUs0YCHtec4?si=Sm-wFC2iPD3hzdCl&amp;start=851"],
            workoutTip: "팔꿈치가 주먹보다 위에 위치할 수 있도록 신경 써 주세요.\n주먹이 내려갈 때 끝까지 내려가지 않고 90퍼센트정도 내려간 곳에서 5초간 정지하고 다시 올라와 보세요."
        )
    ]
    
    init() {
//        for i in 0..<workoutModel.count {
//            workoutModel[i].workoutSet.append(MockUpWorkoutSetModel(index: i + 1, kg: workoutModel.workoutKgs[i], repetition: workoutModel.workoutReps[i], isFinish: false))
//        }
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
