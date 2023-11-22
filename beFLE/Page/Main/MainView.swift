//
//  MainView.swift
//  beFLE
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = MainViewModel.shared
    @State var subscribed = false
    @EnvironmentObject var appState: AppState
    
    init() {
        UITabBar.appearance().backgroundColor = Color.tabbar_main
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.label_600)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.green_main)
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $vm.tabSelection) {
                RoutineView()
                    .tabItem {
                        Image(systemName: "dumbbell")
                        Text("운동")
                    }
                    .tag(0)
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("둘러보기")
                    }
                    .tag(1)
                
                RecordView()
                    .tabItem {
                        Image(systemName: "list.clipboard.fill")
                        Text("기록")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("프로필")
                    }
                    .tag(3)
            }
            .environmentObject(vm)
            .tint(.label_900)
        }
        .id(vm.navigationUUID)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
