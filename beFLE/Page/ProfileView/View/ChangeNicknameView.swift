//
//  ChangeNicknameView.swift
//  beFLE
//
//  Created by 정회승 on 11/8/23.
//

import SwiftUI

struct ChangeNicknameView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ProfileViewModel
    @State var changingNickname: String = ""
    @State private var isSaveActive = false
    @State private var characterCount = 0
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack{
                changeNickname(nickname: vm.nickname)
                Spacer()
            }
        }
        .navigationBarTitle("닉네임 변경", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
            //nill 값이 아니거나 이전 값하고 다를 경우 activate
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
    
    func changeNickname(nickname: String) -> some View {
                HStack(spacing:4){
                    TextField(nickname, text: $changingNickname)
                        .foregroundColor(.label_900)
                        .font(.body())
                        .padding(.leading, 10)
                        .frame(width: UIScreen.getWidth(250), height: UIScreen.getHeight(60))
                    
                    Spacer()
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.label_500)
                        .font(.system(size: 16, weight: .regular, design: .default))
                    //글자수 카운트
                    
                    Text("\(characterCount)/20")
                        .foregroundColor(.label_500)
                        .font(.caption())
                        .padding(.trailing, 10)
                }
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(60))
                .background(Color.gray_700)
                .cornerRadius(4.0)
            .padding(.top, 23)
            .onChange(of: changingNickname) { newValue in
                // Update character count
                characterCount = newValue.count
                isSaveActive = changingNickname != vm.nickname && changingNickname != "" && 1 < characterCount && characterCount <= 20
            }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.headline2())
                .foregroundColor(.label_700)
        }
    }
    
    var SaveButton: some View {
            Button {
                vm.nickname = changingNickname
                //TODO: name Patch 하기 - MORO
                dismiss()
            } label: {
                Text("완료")
                    .font(.headline1())
                    .foregroundColor(.green_main)
            }
        }
    
    var unactiveSaveButton: some View {
        Button {

        } label: {
            Text("완료")
                .font(.headline1())
                .foregroundColor(.label_400)
        }
    }
}

//#Preview {
//    NavigationStack{
//        ChangeNicknameView(nickname: .constant("랜덤닉네임"))
//    }
//}
