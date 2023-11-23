//
//  LaunchView.swift
//  beFLE
//
//  Created by 송재훈 on 11/23/23.
//

import SwiftUI

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

extension LaunchView {
    var LaunchScreen: some View {
        ZStack(alignment: .center) {
            Color.gray_900.ignoresSafeArea()
            
            Image("launchScreenImage")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.getWidth(100), height: UIScreen.getHeight(100))
        }
    }
}

#Preview {
    LaunchView()
}
