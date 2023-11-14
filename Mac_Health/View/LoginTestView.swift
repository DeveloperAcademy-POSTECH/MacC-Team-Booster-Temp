//
//  LoginTestView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/6/23.
//

import SwiftUI
import AuthenticationServices

fileprivate struct LoginTestView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            FloatingButton(backgroundColor: .clear) {
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { results in
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

//MARK: - 유저디폴트를 사용하는 것에 대하여 작성했습니다.
    ///유저를 refreshtoekn과 accesstoken을 받아서 userdefault로 저장하는 과정입니다.
    func saveUser(refreshToken: String, accessToken: String) {
        UserDefaults.standard.setValue(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
    }
    /// 로그인 되어있는지, 확인하는 함수입니다.
    func isLogined() -> Bool {
        //String혹은 nil값이 들어옵니다.
        if UserDefaults.standard.string(forKey: "refreshToken") != nil, UserDefaults.standard.string(forKey: "accessToken") != nil {
            return true
        }
        else {
            return false
        }
    }
    
}

fileprivate struct LoginTestView_Preview: PreviewProvider {
    static var previews: some View {
        LoginTestView()
    }
}
