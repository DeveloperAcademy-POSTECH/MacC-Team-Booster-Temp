//
//  TodaySpecificViewModel.swift
//  Mac_Health
//
//  Created by 정회승 on 11/2/23.
//

import SwiftUI

enum TodaySpecificViewModel: Int, CaseIterable, Identifiable {

    case part
    case setCount
    case time
    case kcal
    
    var image: String {
        switch self {
        case .part: return "figure.arms.open"
        case .setCount: return "square.stack.fill"
        case .time: return "clock.fill"
        case .kcal: return "flame.circle.fill"
        }
    }
    
    var contents: String {
        switch self {
        case .part: return "등, 이두"
        case .setCount: return "6개"
        case .time: return "50분"
        case .kcal: return "580kcal"
        }
    }
    
    var id: Int { return self.rawValue}
    
}
