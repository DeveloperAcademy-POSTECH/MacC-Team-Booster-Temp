//
//  ProfileView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct MockUpProfileView: View {
    //로그인 상태값 모델로 가젹오기
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
    var versionState = "1.0.0"
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack {
                NavigationTitle
                versionInformaion
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal, 20)
                inquiry
                    .disabled(!MailView.canSendMail)
                    .sheet(isPresented: $showMailView) {
                        MailView(data: $mailData) { result in
                        }
                    }
                Divider()
                    .foregroundColor(.gray_700)
                    .padding(.horizontal)
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
    
    func ProfileManage() -> some View {
        
        Button{
            LaunchViewModel.shared.previewLogin()
        } label: {
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.gray_700)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
                .overlay{
                    HStack (spacing:2){
                        Text("둘러보기")
                            .foregroundColor(.label_900)
                            .font(.body())
                            .padding(.leading, 20)
                        Text("님")
                            .foregroundColor(.label_700)
                            .font(.body())
                        Spacer()
                        Text("로그인 하러 가기")
                            .foregroundColor(.green_main)
                            .font(.system(size: 14, weight: .regular, design: .default))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.green_main)
                            .font(.system(size: 10, weight: .regular, design: .default))
                            .padding(.trailing, 20)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            
        }
    }
    
    var versionInformaion : some View {
        VStack (alignment: .leading, spacing: 5){
            HStack {
                Text("버전정보")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
            }
            HStack {
                Text(versionState)
                    .font(.body())
                    .foregroundColor(.label_700)
            }
        }
        .padding()
    }
    
    var inquiry : some View {
        
        Button (action: {
            showMailView.toggle()
        }) {
            VStack (alignment: .leading, spacing: 4){
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
    }
}

//#Preview {
//    NavigationStack{
//        MockUpProfileView()
//    }
//}
