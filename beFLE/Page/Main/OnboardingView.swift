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
    @State var isLoading: Bool = true
    @StateObject var appState = AppState()
    
    var body: some View {
        ZStack{
            if !isPass {
                // 로그인 전
                NavigationStack {
                    Onboarding
                        .onAppear {
                            validateUser()
                        }
                }
            }
            else {
                // 로그인 성공 시
                MainView()
            }
            
            if isLoading {
                LaunchScreen()
                    .transition(.opacity)
                    .zIndex(1)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            withAnimation { isLoading.toggle() }
                        })
                    }
            }
        }
        
        
    }
    
    var Onboarding: some View {
        ZStack {
            Image("LoginImage")
                .resizable()
                .scaledToFill()
            
            /// 온보딩
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading){
                        VStack(alignment: .leading) {
                            Text("몸좋은 사람들의")
                            Text("운동일지 구독")
                        }
                        .font(.title1())
                        .foregroundColor(.label_900)
                        .padding(.bottom, 10)
                        
                        Text("Be my Influencer, BEFLE")
                            .font(.system(size: 20, weight: .light, design: .default))
                            .foregroundColor(.label_700)
                    }
                    .padding(32)
                    .padding(.bottom, 26)
                    Spacer()
                }
                /// 로그인 버튼
                LoginButton
                
                /// 둘러보기 버튼
                PreviewButton
                Spacer()
                    .frame(height: UIScreen.getHeight(68))
            }
            
        }
    }
    
    var LoginButton: some View {
        FloatingButton(backgroundColor: .clear) {
            SignInWithAppleButton(.signIn)
            { request in
                request.requestedScopes = [.email]
            } onCompletion: { results in
                // TODO: 추후 vm 생성 - MORO
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
            .padding(8)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
            .signInWithAppleButtonStyle(.white)
            
        }
        .background {
            FloatingButton(backgroundColor: .white) { }
        }
        .padding(.bottom, 2)
    }
    
    var PreviewButton: some View {
        NavigationLink {
            MockUpMainView()
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(appState)
        } label: {
            FloatingButton(backgroundColor: .gray_600) {
                Text("둘러보기")
                    .foregroundColor(.green_main)
                    .font(.button1())
            }
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
        
#if DEBUG
        print("accessToken: \(UserDefaults.standard.string(forKey: "accessToken"))")
        print("refreshToken: \(UserDefaults.standard.string(forKey: "refreshToken"))")
#endif
    }
    
    /// 자동 로그인 검사 함수
    func validateUser(){
        if let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
            getReissue(refreshToken: refreshToken)
            return
        }
    }
}

struct OnboardingView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnboardingView()
        }
    }
}
