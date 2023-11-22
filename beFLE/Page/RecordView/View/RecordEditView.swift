//
//  RecordEditView.swift
//  beFLE
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
            
            ScrollView {
                ForEach(1...6, id: \.self) {_ in
                    workoutDetail
                }
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
            ForEach(1...4, id: \.self) {_ in
                VStack(alignment: .trailing) {
                    HStack {
                        Spacer()
                        
                        Text("1")
                            .foregroundColor(.label_900)
                            .padding(.trailing, 10)
                            .padding(.trailing, 10)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: UIScreen.getWidth(72), height: UIScreen.getHeight(36))
                            .foregroundColor(.gray_700)
                            .overlay {
                                TextField("자율", value: .constant(5), format: .number)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.label_900)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.trailing, 10)
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
                                    .padding(.trailing, 10)
                            }
                        Text("회")
                            .foregroundColor(.label_700)
                    }
                    .font(.body())
                }
                .padding(.bottom, 15)
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    var SaveButton: some View {
        Button {
            isSaveAlertShow = true
        } label: {
            Text("완료")
                .foregroundColor(.green_main)
                .font(.headline1())
        }
        .alert(isPresented: $isSaveAlertShow){
            let firstButton = Alert.Button.default(Text("취소").bold()) {
//                print("primary button pressed")
            }
            let secondButton = Alert.Button.default(Text("확인")) {
//                print("secondary button pressed")
                dismiss()
            }
            return Alert(title: Text("저장하시겠습니까?"),
                         //                         message: Text(""),
                         primaryButton: firstButton, secondaryButton: secondButton)
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
            let firstButton = Alert.Button.default(Text("취소").bold()) {
//                print("primary button pressed")
            }
            let secondButton = Alert.Button.default(Text("확인")) {
//                print("secondary button pressed")
                dismiss()
            }
            return Alert(title: Text("저장하지 않고 나가시겠습니까?"),
                         //                         message: Text(""),
                         primaryButton: firstButton, secondaryButton: secondButton)
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
