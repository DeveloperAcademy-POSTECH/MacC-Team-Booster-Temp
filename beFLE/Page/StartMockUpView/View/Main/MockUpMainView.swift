//
//  MockUpMainView.swift
//  beFLE
//
//  Created by 정회승 on 11/15/23.
//

import SwiftUI

struct MockUpMainView: View {
    init(showTest: Binding<Bool>) {
        _showTest = showTest
        UITabBar.appearance().backgroundColor = Color.tabbar_main
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.label_600)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(Color.green_main)
    }
    @Binding var showTest: Bool
    @StateObject var vm = MockUpMainViewModel.shared
    @ObservedObject private var stopwatchViewModel = MockUpStopwatchViewModel()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $vm.tabSelection) {
                
                MockUpStartView()
                    .tabItem {
                        Image(systemName: "dumbbell")
                        Text("운동")
                    }
                    .tag(0)
                
                MockUpSearchView(showTest: $showTest)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("둘러보기")
                    }
                    .tag(1)
                
                MockUpRecordView()
                    .tabItem {
                        Image(systemName: "list.clipboard.fill")
                        Text("기록")
                    }
                    .tag(2)
                
                MockUpProfileView(showTest: $showTest)
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

//#Preview {
//    NavigationStack{
//        MockUpMainView(appStatePop: .constant(false))
//    }
//}
