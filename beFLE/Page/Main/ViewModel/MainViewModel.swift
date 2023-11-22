//
//  MainViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static let shared = MainViewModel()
    
    @Published var tabSelection = 0
    @Published var navigationUUID = UUID()
    
    /// 루틴 탭 이동
    func changeToRoutineTab() {
        tabSelection = 0
    }
    
    /// 둘러보기 탭 이동
    func changeToSearchTab() {
        tabSelection = 1
    }
    
    /// 기록 탭 이동
    func changeToRecordTab() {
        tabSelection = 2
    }
    
    /// 프로필 탭 이동
    func changeToProfileTab() {
        tabSelection = 3
    }
    
    func resetNavigationStack() {
        navigationUUID = UUID()
    }
}
