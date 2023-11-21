//
//  NavigationManager.swift
//  Mac_Health
//
//  Created by 정회승 on 11/21/23.
//

import SwiftUI

enum MockUpNavigation: Hashable, Decodable {
    case mockUpStartView
    case mockUpWorkoutOngoingView
    case mockUpFinishView
    case mockUpSearchView
    case mockUpSubscribeView
    case mockUpRecordView
    case mockUpProfileView
}

enum Navigation: Hashable, Decodable {
    case MainView
    case SearchView
    case RecordView
    case ProfileView
}


final class MockUpNavigationManager: ObservableObject {
    @Published var navigatePath = [MockUpNavigation]() {
        didSet {
            print("path\(navigatePath)")
        }
    }
    
    func navigate(_ route: MockUpNavigation) {
        navigatePath.append(route)
    }

    func back() {
        navigatePath.removeLast()
    }

    func countPop(count: Int) {
        navigatePath.removeLast(count)
    }
    
    func countDeque(count: Int) {
        navigatePath.removeFirst(count)
    }
}

final class NavigationManager: ObservableObject {
    @Published var navigatePath = [Navigation]() {
        didSet {
            print("path\(navigatePath)")
        }
    }
    
    func navigate(_ route: Navigation) {
        navigatePath.append(route)
    }

    func back() {
        navigatePath.removeLast()
    }

    func countPop(count: Int) {
        navigatePath.removeLast(count)
    }
    
    func countDeque(count: Int) {
        navigatePath.removeFirst(count)
    }
}

