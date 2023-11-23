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
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $vm.tabSelection) {
                RoutineTab
                SearchTab
                RecordTab
                ProfileTab
            }
            .environmentObject(vm)
            .tint(.label_900)
        }
        .id(vm.navigationUUID)
    }
}

/// 이니셜라이저
extension MainView {
    init() {
        UITabBar.appearance().backgroundColor = Color.tabbar_main
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.label_600)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.green_main)
        self.profileViewModel = ProfileViewModel()
    }
}

/// 탭 구성 요소
extension MainView {
    var RoutineTab: some View {
        RoutineView()
            .tabItem {
                Image(systemName: "dumbbell")
                Text("운동")
            }
            .tag(0)
    }
    
    var SearchTab: some View {
        SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("둘러보기")
            }
            .tag(1)
    }
    
    var RecordTab: some View {
        RecordView()
            .tabItem {
                Image(systemName: "list.clipboard.fill")
                Text("기록")
            }
            .tag(2)
    }
    
    var ProfileTab: some View {
        ProfileView(vm: profileViewModel)
            .tabItem {
                Image(systemName: "person.fill")
                Text("프로필")
            }
            .tag(3)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
