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
    var body: some View {
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
                            let idToken = String(data: userCredential.identityToken!, encoding: .utf8)
                            let authorizationCode = String(data: userCredential.authorizationCode!, encoding: .utf8)
                            
                            print(identifier)
                            print(idToken)
                            print(authorizationCode)
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
        .onAppear {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: "") { (credentialState, error) in
                switch credentialState {
                    case .authorized:
                       print("authorized")
                    case .revoked:
                       print("revoked")
                    case .notFound:
                       print("notFound")
                    default:
                        break
                }
            }
        }
    }

    func saveUser(refreshToken: String, accessToken: String) {
        UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
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
