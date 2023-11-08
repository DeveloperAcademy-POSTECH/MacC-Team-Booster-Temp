//
//  ChangeNicknameView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ChangeNicknameView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var nickname: String
    @State var changingNickname: String = ""
    @State private var isSaveActive = false
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                changeNickname(changedNickname: nickname)
                Spacer()
            }
        }
        .navigationBarTitle("닉네임 변경", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                if isSaveActive {
                                    SaveButton
                                } else {
                                    unactiveSaveButton
                                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func changeNickname(changedNickname: String) -> some View {
                HStack(spacing:2){
                    TextField(changedNickname, text: $changingNickname)
                        .foregroundColor(.label_900)
                        .font(.body())
                        .padding(.leading, 20)
                        .frame(width: UIScreen.getWidth(250), height: UIScreen.getHeight(60))
                    
                    Spacer()
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.label_700)
                        .font(.body())
                    //글자수 카운트
                    Text("12")
                        .foregroundColor(.label_700)
                        .font(.body())
                    Text("/20")
                        .foregroundColor(.label_700)
                        .font(.body())
                        .padding(.trailing, 20)
                }
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                .background(Color.gray_700)
                .cornerRadius(8.0)
            .padding(.top, 20)
            .onChange(of: changingNickname) { _ in
                isSaveActive = changingNickname != nickname
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
    
    var SaveButton: some View {
            Button {
                print("save nickname")
            } label: {
                Text("완료")
                    .font(.headline1())
                    .foregroundColor(.green_main)
            }
        }
    var unactiveSaveButton: some View {
        Button {
            print("need to change name")
        } label: {
            Text("완료")
                .font(.headline1())
                .foregroundColor(.label_400)
        }
    }
}

#Preview {
    NavigationStack{
        ChangeNicknameView(nickname: .constant("랜덤닉네임"))
    }
}
