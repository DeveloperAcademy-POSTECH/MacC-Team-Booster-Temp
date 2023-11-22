//
//  LauchScreen.swift
//  beFLE
//
//  Created by 정회승 on 11/22/23.
//

import SwiftUI

struct LauchScreen: View {
    var body: some View {
        ZStack(alignment: .center){
            Color.gray_900.ignoresSafeArea()
            launchScreenImage
        }
    }
    
    var launchScreenImage: some View {
        Image("launchScreenImage")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.getWidth(100), height: UIScreen.getHeight(100))
    }
}

#Preview {
    LauchScreen()
}
