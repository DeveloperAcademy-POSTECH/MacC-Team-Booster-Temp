//
//  RecordDetailEditView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/27/23.
//

import SwiftUI

struct RecordDetailEditView: View {
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                navigation
                workoutDetail
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    var navigation: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.headline1())
                .foregroundColor(.label_700)
            Spacer()
            
            Text("수정하기")
                .font(.headline1())
                .foregroundColor(.white)
            Spacer()
            
            Image(systemName: "checkmark")
                .font(.headline1())
                .foregroundColor(.label_700)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var workoutDetail: some View {
        VStack {
            HStack {
                Text("클로즈 그립 랫 풀 다운")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
            }
            
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    
                    Text("1")
                        .foregroundColor(.label_900)
                    
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
        .padding(.horizontal)
    }
}

struct RecordDetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailEditView()
    }
}
