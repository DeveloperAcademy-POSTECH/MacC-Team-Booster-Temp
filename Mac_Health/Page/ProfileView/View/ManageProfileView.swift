//
//  ProfileManageView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ManageProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var deletingAccount = false
    @State private var loggingOutSheet = false
    @Binding var nickName: String
    //need 이메일 가리는 logic
    var email = "sam****@naver.com"
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                NicknameBanner(nickName: nickName)
                //TODO: email 받아왔는지 확인
                if email == "" {
                } else {
                    EmailBanner(email: email)
                }
                SignOut(deletingAccount: deletingAccount)
                LogOut(loggingOutSheet: loggingOutSheet)
                Spacer()
            }
        }
        .navigationBarTitle("프로필 관리", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func NicknameBanner(nickName: String) -> some View {
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Text("닉네임")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                NavigationLink {
                    ChangeNicknameView(nickname: $nickName)
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 52, height: 32)
                        .foregroundColor(.gray_700)
                        .overlay{
                            Text("변경")
                                .foregroundColor(.label_900)
                                .font(.button2())
                        }
                }
            }
            
            HStack{
                Text(nickName)
                    .font(.body())
                    .foregroundColor(.label_700)
            }
        }
        .padding([.horizontal, .top])
    }
    
    func EmailBanner(email: String) -> some View {
        VStack(alignment: .leading, spacing: 8){
            Divider()
            HStack{
                Text("이메일")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                    .padding(.top)
            }
            
            HStack{
                Text(email)
                    .font(.body())
                    .foregroundColor(.label_700)
            }
            .padding(.bottom)
            Divider()
        }
        .padding()
    }
    
    func SignOut(deletingAccount: Bool) -> some View {
        Button{
            self.deletingAccount = true
        } label: {
            HStack{
                Text("회원탈퇴")
                    .font(.body())
                    .foregroundColor(.label_700)
                Spacer()
            }
            .padding()
            
        }
        .alert(isPresented: $deletingAccount) {
            let firstButton = Alert.Button.default(Text("취소").bold()) {
                print("primary button pressed")
            }
            let secondButton = Alert.Button.default(Text("탈퇴")) {
                print("secondary button pressed")
            }
            return Alert(title: Text("탈퇴하시겠습니까"),
                         message: Text("탈퇴 시 운동 기록이 모두 삭제됩니다."),
                         primaryButton: firstButton, secondaryButton: secondButton)
        }
    }
    
    func LogOut(loggingOutSheet: Bool) -> some View {
        Button(action: {self.loggingOutSheet = true}, label: {
            HStack{
                Text("로그아웃")
                    .font(.body())
                    .foregroundColor(.label_700)
                Spacer()
            }
            .padding()
            
        })
        .alert("로그아웃하시겠습니까?", isPresented: $loggingOutSheet) {
            Button("취소") { }
            Button{
                
            } label: {
                Text("로그아웃")
                    .bold()
            }
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline1())
                .foregroundColor(.label_700)
        }
    }
}

#Preview {
    NavigationStack{
        ManageProfileView(nickName: .constant("랜덤닉네임04"))
    }
}
