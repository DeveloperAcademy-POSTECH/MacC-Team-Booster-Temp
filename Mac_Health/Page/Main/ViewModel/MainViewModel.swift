//
//  MainViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/15/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var tabSelection = 0
    
    func changeToRoutineTab() {
        tabSelection = 0
    }
    
    func changeToSearchTab() {
        tabSelection = 1
    }
    
    func changeToRecordTab() {
        tabSelection = 2
    }
    
    func changeToProfileTab() {
        tabSelection = 3
    }
}
