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
    
    // TODO: 시저 - showTest 및 연관 함수 제거
    @State var showTest = false
    
    var body: some View {
        switch vm.appState {
        case .launch:
            LaunchScreen
        case .onboarding:
            Onboarding
        case .preview:
            Preview
        case .login:
            Text("login")
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

/// 로그인 상태가 아닐 때 보이는 화면
extension LaunchView {
    var Onboarding: some View {
        OnboardingView()
    }
}

/// 둘러보기일 때 보이는 화면
extension LaunchView {
    var Preview: some View {
        MockUpMainView(showTest: $showTest)
    }
}

#Preview {
    LaunchView()
}
