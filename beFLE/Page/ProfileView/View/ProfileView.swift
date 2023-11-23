//
//  ProfileView.swift
//  beFLE
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                ProfileCard
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal)
                VersionInformaion
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal, 20)
                Inquiry
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal)
                Terms
                Spacer()
            }
            .onAppear {
                vm.fetchNickname()
            }
        }
    }
}

/// 네비게이션 타이틀
extension ProfileView {
    var NavigationTitle: some View {
        HStack {
            Text("프로필")
                .font(.title2())
                .foregroundColor(.label_900)
                .padding(.leading, 3)
            Spacer()
        }
        .padding()
    }
}

/// 프로필 카드
extension ProfileView {
    var ProfileCard: some View {
        NavigationLink {
            ManageProfileView()
                .environmentObject(vm)
        } label: {
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
                .overlay {
                    HStack(spacing:2) {
                        Text(vm.nickname)
                            .foregroundColor(.label_900)
                            .font(.body())
                            .padding(.leading, 20)
                        Text("님")
                            .foregroundColor(.label_700)
                            .font(.body())
                        Spacer()
                        Text("프로필 관리")
                            .foregroundColor(.label_700)
                            .font(.system(size: 14, weight: .regular, design: .default))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.label_700)
                            .font(.system(size: 10, weight: .regular, design: .default))
                            .padding(.trailing, 20)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
        }
    }
}

/// 정보 제공 관련
extension ProfileView {
    /// 앱 버전
    var VersionInformaion: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("버전정보")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
            }
            
            HStack {
                Text(vm.version)
                    .font(.body())
                    .foregroundColor(.label_700)
            }
        }
        .padding()
    }
    
    /// 문의하기
    var Inquiry: some View {
        Button {
            vm.showMailSheet()
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("문의하기")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.vertical)
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .disabled(!MailView.canSendMail)
        .sheet(isPresented: $vm.isMailSheetShow) {
            MailView(data: $vm.mailData) { result in
                print(result)
            }
        }
    }
    
    /// 이용약관 및 개인정보 처리방침
    var Terms: some View {
        Link(destination: URL(string: "https://wiggly-basketball-0a4.notion.site/25e03fbff832400d9bfd8206cb688047")!) {
            VStack(alignment: .leading) {
                HStack {
                    Text("이용약관 및 개인정보처리방침")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.top)
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileView()
}
