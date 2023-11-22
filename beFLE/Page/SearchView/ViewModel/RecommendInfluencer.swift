//
//  RecommendInfluencer.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

enum RecommendInfluencer: CaseIterable {
    case influ1, influ2, influ3
    
    var title: String {
        switch self {
        case .influ1: return "정회승의 Smart Routine"
        case .influ2: return "최진혁의 Special Tip"
        case .influ3: return "이영훈의 Power Building"
        }
    }
    
    var history: String {
        switch self {
        case .influ1: return "2022 Mr. 서울대🏆"
        case .influ2: return "피지크 PRO🏆"
        case .influ3: return "2023 Mr. 서울대🏆"
        }
    }
    
    var influencerImage: Image? {
        switch self {
        case .influ1: return Image("Influencer1")
        case .influ2: return Image("Influencer2")
        case .influ3: return Image("Influencer3")
        }
    }
    var backgroundImage: Image? {
        switch self {
        case .influ1: return Image("Background1")
        case .influ2: return Image("Background2")
        case .influ3: return Image("Background3")
        }
    }
}
