//
//  ProfileViewModel.swift
//  Mac_Health
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    ///현재 이름
    @Published var nickname = "정회승"
    @Published var notiToggle: Bool = true
    @Published var versionState: String = "1.0.0"
    //이름 가져오기
    func GetName(name: String) {

    }
    //PatchUsers로 이름 바꾸기
    func ChangeName(name: String) {
        self.nickname = name
    }
}
