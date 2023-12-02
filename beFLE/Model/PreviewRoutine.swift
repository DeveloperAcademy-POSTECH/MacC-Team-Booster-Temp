//
//  PreviewRoutine.swift
//  beFLE
//
//  Created by 정회승 on 2023/10/22.
//

import Foundation

struct PreviewRoutine: Identifiable {
    let id = UUID()
    var influencer: String
    var part: String
    var workoutName: String
    var setCount: Int
    var repsCount: String
    var exerciseTip: String?
}

let previewRoutine = [
    PreviewRoutine(influencer: "Influencer1", part: "등", workoutName: "클로즈 그립 랫 풀 다운", setCount: 3, repsCount: "10-15", exerciseTip: "고정축이 흔들리면 정확한 타겟이 불가능하기 때문에 꼭! 랫 풀 다운 할 때는 발꿈치를 들어서 무릎 패드와 다리 사이에 공간이 없도록 단단한 지지대를 만들어 주는 것이 굉장히 중요합니다."),
    PreviewRoutine(influencer: "Influencer1", part: "등", workoutName: "와이드 그립 랫 풀 다운", setCount: 3, repsCount: "10-12"),
    PreviewRoutine(influencer: "Influencer1", part: "가슴", workoutName: "벤치 프레스", setCount: 4, repsCount: "8-12"),
    PreviewRoutine(influencer: "Influencer1", part: "가슴", workoutName: "덤벨 플라이", setCount: 4, repsCount: "15")
]
