//
//  ResponseGetInfluencerAllRoutine.swift
//  Mac_Health
//
//  Created by 최진용 on 11/8/23.
//

import SwiftUI

struct ResponseGetInfluencerAllRoutine: Codable {
    var routines: [InfluencerRoutine]
}

struct InfluencerRoutine: Codable {
    var part: String
    var date: Date
    var done: Bool
    var routineId: Int
}
