//
//  LaunchView.swift
//  beFLE
//
//  Created by 송재훈 on 11/23/23.
//

import SwiftUI

/// 앱이 처음 시작되었을 때 보이는 화면
struct LaunchView: View {
    @StateObject var vm = LaunchViewModel.shared
    
    var body: some View {
        switch vm.appState {
        case .launch:
            LaunchScreen
        case .onboarding:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        case .login:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

/// 로그인 검사를 하는 동안 보이는 화면
extension LaunchView {
    var LaunchScreen: some View {
        ZStack(alignment: .center) {
            Color.gray_900.ignoresSafeArea()
            
            Image("launchScreenImage")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.getWidth(100), height: UIScreen.getHeight(100))
        }
        .onAppear {
            vm.loginByUserDefaults()
        }
    }
}

#Preview {
    LaunchView()
}
