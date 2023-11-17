//
//  MainView.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

// TODO: 메인 뷰 모델 추가
struct MainView: View {
    @StateObject var vm = MainViewModel()
    @State var loggedIn = true
    @State var subscribed = false
    
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
                            .font(.subheadline)
                        Text("루틴")
                    }
                    .tag(0)
                
                SearchView(subscribed: $subscribed, tabSelection: $vm.tabSelection)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("둘러보기")
                    }
                    .tag(1)
                
                RecordView(loggedIn: $loggedIn)
                    .tabItem {
                        Image(systemName: "list.clipboard.fill")
                        Text("기록")
                    }
                    .tag(2)
                
                ProfileView(loggedIn: $loggedIn)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("프로필")
                    }
                    .tag(3)
            }
            .environmentObject(vm)
            .tint(.label_900)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
