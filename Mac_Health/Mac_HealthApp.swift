//
//  Mac_HealthApp.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

@main
struct Mac_HealthApp: App {
    var body: some Scene {
        WindowGroup {
//            MainView()
            WorkoutOngoingView(currentWorkoutNumber: 1)
        }
    }
}
