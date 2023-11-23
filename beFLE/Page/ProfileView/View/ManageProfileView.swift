//
//  ProfileManageView.swift
//  beFLE
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ManageProfileView: View {
    @EnvironmentObject var vm: ProfileViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                Nickname
                SignOut(deletingAccount: vm.deletingAccount)
                LogOut(loggingOutSheet: vm.loggingOutSheet)
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
    
    func EmailBanner(email: String) -> some View {
        VStack(alignment: .leading, spacing: 5){
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
                .padding(.horizontal)
                .foregroundColor(.gray_700)
        }
        .padding()
    }
    
    func SignOut(deletingAccount: Bool) -> some View {
        Button{
            self.vm.deletingAccount = true
        } label: {
            HStack{
                Text("회원탈퇴")
                    .font(.body())
                    .foregroundColor(.label_700)
                Spacer()
            }
            .padding()
            .padding(.top)
            
        }
        .alert(isPresented: $vm.deletingAccount) {
            let firstButton = Alert.Button.default(Text("취소").bold()) {
                
            }
            let secondButton = Alert.Button.default(Text("탈퇴")) {
                vm.withdrawAccount()
                vm.logout()
            }
            return Alert(title: Text("탈퇴하시겠습니까"),
                         message: Text("탈퇴 시 운동 기록이 모두 삭제됩니다."),
                         primaryButton: firstButton, secondaryButton: secondButton)
        }
    }
    
    func LogOut(loggingOutSheet: Bool) -> some View {
        Button(action: {self.vm.loggingOutSheet = true}, label: {
            HStack{
                Text("로그아웃")
                    .font(.body())
                    .foregroundColor(.label_700)
                Spacer()
            }
            .padding()
            
        })
        .alert("로그아웃하시겠습니까?", isPresented: $vm.loggingOutSheet) {
            Button("취소") { }
            Button{
                vm.logout()
            } label: {
                Text("로그아웃")
                    .bold()
            }
        }
    }
}

/// 네비게이션 타이틀
extension ManageProfileView {
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline2())
                .foregroundColor(.label_700)
        }
    }
}

/// 닉네임 관련
extension ManageProfileView {
    var Nickname: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("닉네임")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                    Spacer()
                    NavigationLink {
                        ChangeNicknameView(vm: vm)
                    } label: {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: UIScreen.getWidth(52), height: UIScreen.getHeight(32))
                            .foregroundColor(.gray_700)
                            .overlay {
                                Text("변경")
                                    .foregroundColor(.label_900)
                                    .font(.button2())
                            }
                    }
                }
                HStack {
                    Text(vm.nickname)
                        .font(.body())
                        .foregroundColor(.label_700)
                }
            }
            .padding([.horizontal, .top])
            .padding(.vertical)
            Divider()
                .foregroundColor(.gray_700)
                .padding(.horizontal)
        }
    }
}
