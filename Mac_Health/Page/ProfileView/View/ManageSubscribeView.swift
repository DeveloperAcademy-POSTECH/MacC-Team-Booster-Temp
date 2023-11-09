//
//  ManageSubscribeView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/9/23.
//

import SwiftUI

struct ManageSubscribeView: View {
    
    @State var cancelingSubscribed: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            //if 구독 내역 없으면
//            Text("구독 내역이 없습니다.")
//                .font(.headline1())
            
            ScrollView{
                subscribeBanner(title: "정회승의 Smart Routine", date: "2023.07.03~")
                subscribeBanner(title: "이현웅의 Special Tip", date: "2023.08.03~")
                Spacer()
            }
        }
        .navigationBarTitle("구독 관리", displayMode: .inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton
            }
        }
    }
    
    func subscribeBanner(title: String, date: String) -> some View {
        VStack(alignment: .leading, spacing: 8){
            HStack{
                Text(title)
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                Button {
                    self.cancelingSubscribed = true
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 76, height: 32)
                        .foregroundColor(.gray_700)
                        .overlay{
                            Text("구독 취소")
                                .foregroundColor(.label_900)
                                .font(.button2())
                        }
                }
                .alert(isPresented: $cancelingSubscribed) {
                    Alert(
                        title: Text("구독을 취소하시겠습니까?"),
        //                message: Text(""),
                        primaryButton: .destructive(Text("확인"),
                                                action: {

                                        }),
                                        secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
            
            HStack{
                Text(date)
                    .font(.body())
                    .foregroundColor(.label_700)
            }
            }
        .padding([.horizontal, .top])
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
        ManageSubscribeView()
    }
}
