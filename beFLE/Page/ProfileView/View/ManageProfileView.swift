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
                Withdraw
                Logout
                Spacer()
            }
        }
        .navigationBarTitle("프로필 관리", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
        .gesture(
            DragGesture().onChanged { value in
                if value.startLocation.x < 50 {
                    vm.offset = value.translation.width
                }
            }
                .onEnded { value in
                    if value.predictedEndTranslation.width > 100 {
                        dismiss()
                    }
                    vm.offset = .zero
                }
        )
        .offset(x: vm.offset)
        .animation(.easeInOut)
        .navigationBarBackButtonHidden()
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

/// 계정 관련
extension ManageProfileView {
    var Withdraw: some View {
        Button {
            vm.showWithdrawAlert()
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
        .alert("탈퇴하시겠습니까", isPresented: $vm.isWithdrawAlertShow) {
            Button {
                
            } label: {
                Text("취소")
                    .bold()
            }
            
            Button {
                vm.withdrawAccount()
                vm.logout()
            } label: {
                Text("탈퇴")
            }
        } message: {
            Text("탈퇴 시 운동 기록이 모두 삭제됩니다.")
        }
    }
    
    var Logout: some View {
        Button {
            vm.showLogoutAlert()
        } label: {
            HStack { 
                Text("로그아웃")
                    .font(.body())
                    .foregroundColor(.label_700)
                Spacer()
            }
            .padding()
        }
        .alert("로그아웃하시겠습니까?", isPresented: $vm.isLogoutAlertShow) {
            Button {
                
            } label: {
                Text("취소")
            }
            
            Button {
                vm.logout()
            } label: {
                Text("로그아웃")
                    .bold()
            }
        }
    }
}
