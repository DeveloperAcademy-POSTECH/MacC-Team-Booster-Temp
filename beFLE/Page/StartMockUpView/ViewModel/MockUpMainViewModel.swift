//
//  File.swift
//  beFLE
//
//  Created by 정회승 on 11/23/23.
//

import SwiftUI

class MockUpMainViewModel: ObservableObject {
    static let shared = MockUpMainViewModel()
    
    @Published var navigationUUID = UUID()
    @Published var tabSelection = 0
    
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
