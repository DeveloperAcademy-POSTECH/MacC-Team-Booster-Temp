//
//  MainView.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = Color.tabbar_main
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.label_600)
    }
    @State private var path = NavigationPath()
    @State private var tabSelection = 1
    
    var body: some View {
        NavigationStack(path: $path) {
            TabView(selection: $tabSelection){
                //TODO: 로그인 전/ 구독전/ 구독 후 구분
//                BeforeSubscribeView(tabSelection: $tabSelection)
                TodayStartView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "dumbbell")
                        Text("루틴")
                    }
                    .tag(1)
                
                SearchView(tabSelection: $tabSelection)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("둘러보기")
                    }
                    .tag(2)
                
                RecordView()
                    .tabItem {
                        Image(systemName: "list.clipboard.fill")
                        Text("기록")
                    }
                    .tag(3)
                
                ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                }
                .tag(4)
            }
            .tint(.label_900)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
