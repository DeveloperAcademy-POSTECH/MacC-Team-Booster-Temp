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
    
    var body: some View {
        NavigationStack {
            TabView {
                TodayStartView()
                    .tabItem {
                        Image(systemName: "dumbbell")
                        Text("루틴")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("둘러보기")
                    }
                
                RecordView()
                    .tabItem {
                        Image(systemName: "list.clipboard.fill")
                        Text("기록")
                    }
                
                ZStack{
                    Color.gray_900.ignoresSafeArea()
                    Text("profile")
                        .foregroundColor(.white)
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                }
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
