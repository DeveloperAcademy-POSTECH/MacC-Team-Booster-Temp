//
//  PaymentView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/22.
//

import SwiftUI

struct PaymentView: View {
    
    var routineTitle = "정회승의 Smart Routine"
    var influencerImage = "Influencer1"
    var backgroundImage = "Background1"
    
    var body: some View {
        ZStack{
            //배경색
        Color.gray_900.ignoresSafeArea()
            
            ScrollView {
                VStack{
                    paymentCard
                        .padding(.bottom, 20)
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(80))
                        
                }
            }
        }
    }
    
    @ViewBuilder
    var paymentCard: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.gray_700)
            HStack{
                VStack(alignment: .leading){
                    Text(routineTitle)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.leading, 20)
                }
                .frame(height: UIScreen.getHeight(156))
                Spacer()
                ZStack{
                    HStack{
                        Spacer()
                        Image(backgroundImage)
                            .resizable()
                            .scaledToFit()
                    }
                    Image(influencerImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.getHeight(72))
                        .padding(.top, 50)
                }
                .frame(width: UIScreen.getWidth(156))
            }
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .mask(
         RoundedRectangle(cornerRadius: 8)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
         )

    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
