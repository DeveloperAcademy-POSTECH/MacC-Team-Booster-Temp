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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LaunchView()
}
