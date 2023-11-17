//
//  SubscribeViewModel.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/18/23.
//

import SwiftUI

class SubscribeViewModel: ObservableObject {
    //    @State var seeMore:Bool = false
    @Published var showTab = false
    @Published var scrollOffset: CGFloat = 0.00
    @Published var subscribingSheet = false
    @Published var loggedIn = true
}
