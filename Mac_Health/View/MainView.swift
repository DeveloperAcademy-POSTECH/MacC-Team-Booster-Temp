//
//  ContentView.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/19.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("루틴")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("둘러보기")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("기록")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("프로필")
                }
        }
        
        .ignoresSafeArea()
        .tint(.label_700)
        .onAppear() {
                                UITabBar.appearance().barTintColor = .black
                                   }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
