//
//  LoginTestView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/6/23.
//

import SwiftUI
import AuthenticationServices

// TODO: 추후 온보딩으로 변경
struct LoginTestView: View {
    @State var isPass = false
    
    var body: some View {
        // 로그인 성공 시
        if isPass {
            MainView()
        }
        // 로그인 전
        else {
            ZStack {
                // TODO: 색 변경
                Color.gray.ignoresSafeArea()
                
                // TODO: 사이즈 변경
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
            }
            //        .onAppear {
            //            let appleIDProvider = ASAuthorizationAppleIDProvider()
            //            appleIDProvider.getCredentialState(forUserID: "") { (credentialState, error) in
            //                switch credentialState {
            //                    case .authorized:
            //                       print("authorized")
            //                    case .revoked:
            //                       print("revoked")
            //                    case .notFound:
            //                       print("notFound")
            //                    default:
            //                        break
            //                }
            //            }
            //        }
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
    
    /// 전달 받은 액세스 토큰 유저 디폴트 저장 함수
    func saveUser(accessToken: String, refreshToken: String) {
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
        UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
    }
    
    func isLogined() -> Bool {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.string(forKey: "refreshToken") != nil, userDefaults.string(forKey: "accessToken") != nil {
            return true
        }
        else {
            return false
        }
    }
}

struct LoginTestView_Preview: PreviewProvider {
    static var previews: some View {
        LoginTestView()
    }
}
