//
//  OnboardingView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/6/23.
//

import SwiftUI
import AuthenticationServices

/// 앱 시작 시 처음 보이는 화면
struct OnboardingView: View {
    @State var isPass = false
    
    var body: some View {
        if !isPass {
            // 로그인 전
            NavigationStack {
                Onboarding
            }
        }
        else {
            // 로그인 성공 시
            MainView()
        }
    }
    
    // TODO: 뷰 디테일 작업
    var Onboarding: some View {
        ZStack {
            // TODO: 색 변경
            Color.gray.ignoresSafeArea()
            
            // TODO: 텍스트 사이즈 변경
            VStack {
                FloatingButton(backgroundColor: .clear) {
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.email]
                    } onCompletion: { results in
                        // TODO: 추후 vm 생성
                        switch results {
                        case .success(let result):
                            switch result.credential {
                            case let userCredential as ASAuthorizationAppleIDCredential:
                                let identifier = userCredential.user
                                let identityToken = String(data: userCredential.identityToken!, encoding: .utf8)
                                let authorizationCode = String(data: userCredential.authorizationCode!, encoding: .utf8)
                                
                                postLogin(identifier: identifier, identityToken: identityToken!, authorizationCode: authorizationCode!)
                            default:
                                break
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .cornerRadius(100)
                    .signInWithAppleButtonStyle(.white)
                }
                // TODO: 둘러보기 버튼 추가
                NavigationLink {
                    MockUpStartView(tabSelection: .constant(1))
                } label: {
                    FloatingButton(backgroundColor: .fill_2) {
                        Text("둘러보기")
                    }
                }
            }
        }
        .onAppear {
            isLogined()
        }
    }
    
    /// 애플 로그인 성공 시 서버에 액세스 토큰 요청 함수
    func postLogin(identifier: String, identityToken: String, authorizationCode: String) {
        GeneralAPIManger.request(for: .PostLogin(identifier: identifier, identityToken: identityToken, authorizationCode: authorizationCode), type: Token.self) {
            switch $0 {
            case .success(let token):
                saveUser(accessToken: token.accessToken, refreshToken: token.refreshToken)
                self.isPass = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 자동 로그인 용 토큰 재발급 함수
    func getReissue(refreshToken: String) {
        GeneralAPIManger.request(for: .GetReissue(refreshToken: refreshToken), type: Token.self) {
            switch $0 {
            case .success(let token):
                saveUser(accessToken: token.accessToken, refreshToken: token.refreshToken)
                self.isPass = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 전달 받은 액세스 토큰 유저 디폴트 저장 함수
    func saveUser(accessToken: String, refreshToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
        UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
    }
    
    /// 자동 로그인 검사 함수
    func isLogined(){
        if let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
            getReissue(refreshToken: refreshToken)
            return
        }
        // TODO: 액세스 토큰 분기? - 필요한지 잘 모르겠음
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
