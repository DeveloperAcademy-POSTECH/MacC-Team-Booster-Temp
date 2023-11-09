//
//  RecordEditView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/27/23.
//

import SwiftUI

struct RecordEditView: View {
    @State var isSaveAlertShow = false
    @State var isUnsaveAlertShow = false
    @Environment(\.dismiss) var dismiss: DismissAction
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                workoutDetail
                Spacer()
            }
        }
        
        .navigationBarTitle("수정하기", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ExitButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    SaveButton
                }
            }
            .navigationBarBackButtonHidden(true)
    }
    
    
    @ViewBuilder
    var workoutDetail: some View {
        VStack {
            HStack {
                Text("클로즈 그립 랫 풀 다운")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                Button{
                    
                }label: {
                    Image(systemName: "trash.fill")
                        .font(.body())
                        .foregroundColor(.label_700)
                }
            }
            .padding(.vertical)
            
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    
                    Text("1")
                        .foregroundColor(.label_900)
                        .padding(.trailing, 10)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                        .foregroundColor(.gray_700)
                        .overlay {
                            TextField("자율", value: .constant(5), format: .number)
                                .keyboardType(.numberPad)
                                .foregroundColor(.label_900)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing)
                        }
                    Text("kg")
                        .foregroundColor(.label_700)
                        .padding(.trailing, 10)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                        .foregroundColor(.gray_700)
                        .overlay {
                            TextField("", value: .constant(5), format: .number)
                                .keyboardType(.numberPad)
                                .foregroundColor(.label_900)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing)
                        }
                    Text("회")
                        .foregroundColor(.label_700)
                }
                .font(.body())
            }
        }
        .padding()
    }
    
    var SaveButton: some View {
        Button {
            print("save")
            isSaveAlertShow = true
        } label: {
            Text("완료")
                .foregroundColor(.green_main)
                .font(.headline1())
        }
        .alert(isPresented: $isSaveAlertShow){
            Alert(
                title: Text("저장하시겠습니까?"),
                message: Text(""),
                primaryButton: .destructive(Text("확인"),
                                        action: {
                                            dismiss()
                                }),
                                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
    
    var ExitButton: some View {
        Button {
            print("exit")
            isUnsaveAlertShow = true
        } label: {
            Image(systemName: "multiply")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
        .alert(isPresented: $isUnsaveAlertShow){
            Alert(
                title: Text("저장하지 않고 나가시겠습니까?"),
//                message: Text(""),
                primaryButton: .destructive(Text("확인"),
                                        action: {
                                            dismiss()
                                }),
                                secondaryButton: .cancel(Text("취소"))
            )
        }
    }
}

struct RecordEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            RecordEditView()
        }
    }
}
