//
//  ProfileViewModel.swift
//  Mac_Health
//
//  Created by 정회승 on 11/16/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    ///현재 이름
    //TODO: nickname에 서버 User name 받아오기 - MORO
    @Published var nickname = "정회승"
    @Published var notiToggle: Bool = true
    @Published var versionState: String = "1.0.0"
    
    @Published var email = "king81597@naver.com"
    
    @Published var deletingAccount = false
    @Published var loggingOutSheet = false
    //이름 가져오기
    func GetName(name: String) {

    }
    //PatchUsers로 이름 바꾸기
    func FetchName(name: String) {
        self.nickname = name
    }
}
