//
//  LoginTestView.swift
//  Mac_Health
//
//  Created by 송재훈 on 11/6/23.
//

import SwiftUI
import AuthenticationServices

struct LoginTestView: View {
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
                            let fullName = userCredential.fullName
                            let name = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                            let idToken = String(data: userCredential.identityToken!, encoding: .utf8)
                            let authorizationCode = String(data: userCredential.authorizationCode!, encoding: .utf8)
                            
                            print(identifier)
                            print(fullName)
                            print(name)
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
            appleIDProvider.getCredentialState(forUserID: "000376.30357e79eb8a443ea573b62544408c6b.1202") { (credentialState, error) in
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
}

struct LoginTestView_Preview: PreviewProvider {
    static var previews: some View {
        LoginTestView()
    }
}
