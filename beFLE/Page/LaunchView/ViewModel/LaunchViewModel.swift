//
//  LaunchViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/23/23.
//

import SwiftUI

class LaunchViewModel: ObservableObject {
    @Published var appState: AppState = .launch
}

extension LaunchViewModel {
    enum AppState {
        case launch
        case onboarding
        case login
    }
}
