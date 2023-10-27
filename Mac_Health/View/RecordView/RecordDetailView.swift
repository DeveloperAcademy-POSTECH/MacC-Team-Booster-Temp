//
//  RecordDetailView.swift
//  Mac_Health
//
//  Created by 송재훈 on 10/27/23.
//

import SwiftUI

struct RecordDetailView: View {
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            VStack {
                navigation
                recordCard
                workoutDetail
                workoutDetail
                workoutDetail
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    var navigation: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "chevron.left")
                    .font(.headline1())
                    .foregroundColor(.label_700)
            }
            Spacer()
            
            Text("2023년 6월 23일")
                .font(.headline1())
                .foregroundColor(.white)
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "pencil")
                    .font(.headline1())
                    .foregroundColor(.label_700)
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var recordCard: some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.fill_1)
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .overlay {
                VStack {
                    HStack {
                        Ellipse()
                            .frame(width: UIScreen.getWidth(8), height: UIScreen.getHeight(8))
                            .foregroundColor(.yellow_main)
                        Text("박재훈")
                            .font(.headline2())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Text("1시간 32분 12초")
                            .font(.headline2())
                            .foregroundColor(.label_900)
                    }
                    Spacer()
                    HStack {
                        Text("등/가슴")
                            .font(.body2())
                            .foregroundColor(.label_900)
                        Spacer()
                        
                        Text("14500kg")
                            .font(.body2())
                            .foregroundColor(.label_900)
                    }
                }
                .padding()
            }
    }
    
    @ViewBuilder
    var workoutDetail: some View {
        VStack {
            HStack {
                Text("클로즈 그립 랫 풀 다운")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                
                Text("1450kg")
                    .font(.headline1())
                    .foregroundColor(.label_900)
            }
            
            HStack {
                Spacer()
                Text("1세트")
                    .font(.body2())
                    .foregroundColor(.label_700)
                
                Text("40kg")
                    .font(.body2())
                    .foregroundColor(.label_700)
                Image(systemName: "xmark")
                    .font(.body2())
                    .foregroundColor(.label_400)
                Text("10회")
                    .font(.body2())
                    .foregroundColor(.label_700)
            }
        }
        .padding(.horizontal)
    }
}

struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView()
    }
}
