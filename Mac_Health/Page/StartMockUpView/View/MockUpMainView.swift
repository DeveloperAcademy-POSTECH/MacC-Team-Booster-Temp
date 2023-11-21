//
//  MockUpMainView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/15/23.
//

import SwiftUI

struct MockUpMainView: View {
    init() {
        UITabBar.appearance().backgroundColor = Color.tabbar_main
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.label_600)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.green_main)
    }
    @State private var tabSelection = 1
    @State var loggedIn = false
    @ObservedObject private var stopwatchViewModel = MockUpStopwatchViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            MockUpStartView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("운동")
                }
                .tag(1)

            MockUpSearchView(tabSelection: $tabSelection)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("둘러보기")
                }
                .tag(2)
            
            RecordView(loggedIn: $loggedIn)
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("기록")
                }
                .tag(3)
            
            ProfileView(loggedIn: $loggedIn)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                }
                .tag(4)
        }
        .tint(.label_900)
    }
}

//#Preview {
//    NavigationStack{
//        MockUpMainView(appStatePop: .constant(false))
//    }
//}
