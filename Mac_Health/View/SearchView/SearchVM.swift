//
//  SearchViewMV.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/20.
//

import SwiftUI

class SearchVM: ObservableObject {
    
    var recommend: RecommendInfluencer?
    
    @Published var currentIndex: Int = 0
}
