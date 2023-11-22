//
//  ProfileView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var vm = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var mailData = ComposeMailData(subject: "비플 문의하기",
                                                  recipients: ["pmchung423@gmail.com"],
                                                  message: "비플 문의하기",
                                                  attachments: [
                                                    //                                                    AttachmentData(data: "Some text".data(using: .utf8)!,
                                                    //                                                                               mimeType: "text/plain",
                                                    //                                                                               fileName: "text.txt")
                                                  ]
    )
    @State private var showMailView = false
    
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                NavigationTitle
                NavigationLink {
                    ManageProfileView(vm: vm)
                } label: {
                    ProfileManage(nickname: vm.nickname)
                }
                
                //로그인 전 unactive
                AlertToggle(notiToggle: vm.notiToggle)
                
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal)
                versionInformaion
                //로그인 전 unactive
                //                loggedIn ?
                //                NavigationLink {
                //                    ManageSubscribeView()
                //                } label: {
                //                    subscribeManagement
                //                } : nil
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal, 20)
                Button(action: {
                    showMailView.toggle()
                }) {
                    inquiry
                }
                .disabled(!MailView.canSendMail)
                .sheet(isPresented: $showMailView) {
                    MailView(data: $mailData) { result in
                        
                    }
                }
                //로그인 전 unactive
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal)
                useInformation
                Spacer()
            }
        }
    }

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

func ProfileManage(nickname: String) -> some View {
    RoundedRectangle(cornerRadius: 8.0)
        .foregroundColor(.gray_700)
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
        .overlay{
            HStack(spacing:2){
                //로그인 x -> nickName => "둘러보기", "프로필 관리" => "로그인 하러 가기"
                Text(nickname)
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

func AlertToggle(notiToggle: Bool) -> some View {
    VStack(alignment: .leading, spacing: 5){
        HStack{
            Text("알림")
                .font(.headline1())
                .foregroundColor(.label_900)
            Spacer()
            
            Toggle("", isOn: $vm.notiToggle)
                .toggleStyle(SwitchToggleStyle(tint: Color.green_main))
        }
        
        HStack{
            Text("운동 일지 업데이트 알림")
                .font(.body())
                .foregroundColor(.label_700)
        }
        .padding(.bottom)
    }
    .padding(.top, 10)
    .padding(.horizontal)
}

var versionInformaion : some View {
    VStack(alignment: .leading, spacing: 5){
        HStack{
            Text("버전정보")
                .font(.headline1())
                .foregroundColor(.label_900)
            Spacer()
        }
        
        HStack{
            Text(vm.versionState)
                .font(.body())
                .foregroundColor(.label_700)
        }
    }
    .padding()
}

//    var subscribeManagement : some View {
//        //노션 페이지 마련
//        VStack(alignment: .leading, spacing: 4){
//            Divider()
//                .foregroundColor(.gray_700)
//            Text("구독관리")
//                .font(.headline1())
//                .foregroundColor(.label_900)
//                .padding(.vertical)
//        }
//        .padding(.horizontal)
//    }

var inquiry : some View {
    //이메일 모달
    VStack(alignment: .leading, spacing: 4){
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

var useInformation : some View {
    //노션 페이지 마련
    Link(destination: URL(string: "https://wiggly-basketball-0a4.notion.site/25e03fbff832400d9bfd8206cb688047" )!) {
        VStack(alignment: .leading){
            HStack{
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
    NavigationStack{
        ProfileView()
    }
}
