//
//  ProfileView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ProfileView: View {
    @State var nickName: String = "random04"
    @State var notiToggle: Bool = true
    @State var versionState: String = "1.0.0"
    //로그인 상태값 모델로 가젹오기
    @State var loggedIn: Bool = true
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                NavigationTitle
                NavigationLink {
                    ManageProfileView(nickName: $nickName)
                } label: {
                    ProfileManage(nickName: nickName)
                }
                //로그인 전 unactive
                loggedIn ? AlertToggle(notiToggle: notiToggle) : nil
                versionInformaion
                //로그인 전 unactive
                loggedIn ? 
                NavigationLink {
                    ManageSubscribeView()
                } label: {
                    subscribeManagement
                } : nil
                inquiry
                //로그인 전 unactive
                loggedIn ? useInformation : nil
                Spacer()
                }
            }
        }
    
    var NavigationTitle: some View {
        HStack {
            Text("프로필")
                .font(.title2())
                .foregroundColor(.label_900)
            Spacer()
        }
        .padding()
    }
    
    func ProfileManage(nickName: String) -> some View {
        RoundedRectangle(cornerRadius: 8.0)
            .foregroundColor(.gray_700)
            .frame(width: UIScreen.getWidth(360), height: UIScreen.getHeight(72))
            .overlay{
                HStack(spacing:2){
                    //로그인 x -> nickName => "둘러보기", "프로필 관리" => "로그인 하러 가기"
                    Text(loggedIn ? nickName : "둘러보기")
                        .foregroundColor(.label_900)
                        .font(.body())
                        .padding(.leading, 20)
                    Text("님")
                        .foregroundColor(.label_700)
                        .font(.body())
                    Spacer()
                    Text(loggedIn ? "프로필 관리" : "로그인 하러 가기")
                        .foregroundColor(loggedIn ? .label_700 : .green_main)
                        .font(.body())
                    Image(systemName: "chevron.right")
                        .foregroundColor(loggedIn ? .label_700 : .green_main)
                        .font(.body2())
                        .padding(.trailing, 20)
                }
            }
            .padding(.top, 20)
    }
    
    func AlertToggle(notiToggle: Bool) -> some View {
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Text("알림")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                
                Toggle("", isOn: $notiToggle)
                    .toggleStyle(SwitchToggleStyle(tint: Color.green_main))
            }
            
            HStack{
                Text("운동 일지 업데이트 알림")
                    .font(.body())
                    .foregroundColor(.label_700)
            }
            Divider()
            }
        .padding()
    }
    
    var versionInformaion : some View {
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Text("버전정보")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                    .padding(.top)
                Spacer()
            }
            
            HStack{
                Text(versionState)
                    .font(.body())
                    .foregroundColor(.label_700)
                    .padding(.bottom)
            }
            }
        .padding(.horizontal)
    }
    
    var subscribeManagement : some View {
        //노션 페이지 마련
        VStack(alignment: .leading, spacing: 8){
            Divider()
                Text("구독관리")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                    .padding(.vertical)
            }
        .padding(.horizontal)

    }
    
    var inquiry : some View {
        //이메일 모달
        VStack(alignment: .leading, spacing: 8){
            Divider()
                Text("문의하기")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                    .padding(.vertical)
            }
        .padding(.horizontal)

    }
    
    var useInformation : some View {
        //노션 페이지 마련
        VStack(alignment: .leading, spacing: 8){
            Divider()
                Text("이용약관 및 개인정보처리방침")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                    .padding(.top)
            }
        .padding(.horizontal)

    }
    
    
}

#Preview {
    NavigationStack{
        ProfileView()
    }
}
