//
//  ResponseGetSpecificExercise.swift
//  Mac_Health
//
//  Created by 최진용 on 11/8/23.
//

import SwiftUI

struct ResponseGetSpecificExercise: Codable {
    var name: String
    var part: String
    var exerciseId: Int
    var exerciseImageUrl: String
    var tip: String
    var videoUrl: String
    var sets: [Set]

}

