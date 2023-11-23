//
//  LaunchViewModel.swift
//  beFLE
//
//  Created by 송재훈 on 11/23/23.
//

import SwiftUI

class LaunchViewModel: ObservableObject {
    static let shared = LaunchViewModel()
    
    @Published var appState: AppState = .launch
}

/// 로그인 관련
extension LaunchViewModel {
    /// 로그인 상태
    enum AppState {
        case launch
        case onboarding
        case preview
        case login
    }
    
    /// 자동 로그인 검사 함수
    func loginByUserDefaults(){
        if let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
            reissueToken(refreshToken: refreshToken)
            return
        }
        else {
            appState = .onboarding
        }
    }
    
    /// 애플 로그인 성공 시 액세스 토큰 요청 함수
    func loginByAppleLogin(identifier: String, identityToken: String, authorizationCode: String) {
        GeneralAPIManger.request(for: .PostLogin(identifier: identifier, identityToken: identityToken, authorizationCode: authorizationCode), type: Token.self) {
            switch $0 {
            case .success(let token):
                self.saveToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
                self.appState = .login
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 토큰 재발급 요청 함수
    func reissueToken(refreshToken: String) {
        GeneralAPIManger.request(for: .GetReissue(refreshToken: refreshToken), type: Token.self) {
            switch $0 {
            case .success(let token):
                self.saveToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
                self.appState = .login
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 전달 받은 액세스 토큰 저장 함수
    func saveToken(accessToken: String, refreshToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
        UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        
#if DEBUG
        print("accessToken: \(String(describing: UserDefaults.standard.string(forKey: "accessToken")))")
        print("refreshToken: \(String(describing: UserDefaults.standard.string(forKey: "refreshToken")))")
#endif
    }
}
