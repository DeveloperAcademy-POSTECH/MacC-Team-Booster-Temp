//
//  ContentView.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

/*
 데이터 흐름
 
 */


import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = Color.tabbar_main
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.label_600)
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                StartView()
                    .tabItem {
                        Image(systemName: "dumbbell")
                        Text("루틴")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("둘러보기")
                    }
                
                ZStack{
                    Color.gray_900.ignoresSafeArea()
                    Text("record")
                        .foregroundColor(.white)
                }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
