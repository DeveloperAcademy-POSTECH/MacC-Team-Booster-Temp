//
//  ManageSubscribeView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/9/23.
//

import SwiftUI

struct ManageSubscribeView: View {
    
    var title: String = "정회승의 Smart Routine"
    var startDate: String = "2023.07.03"
    @State var cancelingSubscribed: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            //if 구독 내역 없으면
//            Text("구독 내역이 없습니다.")
//                .font(.headline1())
            
            ScrollView{
                subscribeBanner(title: title, date: "\(startDate)~")
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
                    cancelingSubscribed.toggle()
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
                //TODO: 여기서 취소버튼누르면 네트워킹 쏴줘야함.
                .alert("구독을 취소하시겠습니까?", isPresented: $cancelingSubscribed) {
                    Button("취소") { }
                    Button{
                        
                    } label: {
                         Text("확인")
                            .bold()
                    }
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
