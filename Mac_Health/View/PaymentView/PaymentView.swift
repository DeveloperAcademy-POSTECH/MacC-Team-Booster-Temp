//
//  PaymentView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/22.
//

import SwiftUI

struct PaymentView: View {
    
    @State var paymentSelected = false
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var routineTitle = "정회승의 Smart Routine"
    var appStoreExplain: Array = [
        "App Store 결제는 현재 사용하고 있는 App Store 계정을 통해 결제 됩니다.",
        "일부 사용자의 경우, App Store 상황에 따라 구독 마지막 날 결제될 수 있습니다.",
        "결제 금액에는 수수료가 포함되어 있습니다.",
        "결제 금액에 대한 확인 및 환불은 Apple을 통해 가능합니다.",
    ]
    
    var body: some View {
        ZStack{
            //배경색
        Color.gray_900.ignoresSafeArea()
            
            ScrollView {
                VStack{
                    //루틴 카드
                    paymentCard
                        .padding(.bottom, 20)
                    
                    //할인 혜택
                    Button {
                        paymentSelected.toggle()
                        print("1달 선택")
                    } label: {
                        SelectedPaymentButton(month: "1개월", price: "9,900", paymentSelected: $paymentSelected, discounted: false)
                    }
                    Button {
                        paymentSelected.toggle()
                        print("3달 선택")
                    } label: {
                        SelectedPaymentButton(month: "3개월", price: "23,400", paymentSelected: $paymentSelected, discounted: false)
                    }
                    Button {
                        paymentSelected.toggle()
                        print("6달 선택")
                    } label: {
                        SelectedPaymentButton(month: "6개월", price: "32,400", paymentSelected: $paymentSelected, discounted: false)
                    }
                    
                    //앱스토어 구매안내
                    appStoreDescription
                }
            }
            //구독 버튼
            VStack {
                Spacer()
                paymentButton
//                    .padding(.bottom, 20)
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
            }
            Image("TopBanner1")
            .resizable()
            .scaledToFit()
        }
        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
            .mask(
         RoundedRectangle(cornerRadius: 8)
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(72))
         )

    }
    
    @ViewBuilder
    var selectingPayment: some View {
        
        Rectangle()
                        .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(80))
                        .foregroundColor(paymentSelected ? Color.green_10 : Color.gray_900)
                        .cornerRadius(8)
                        .overlay{
                            HStack{
                                Text("1개월")
                                Spacer()
                                Text("9,900원")
                            }
                            .foregroundColor(.label_900)
                            .font(.headline1())
                            .padding(20)
                            .foregroundColor(.white)
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                                .foregroundColor(paymentSelected ? .green_main : .label_500)
        
                        }
                        .padding(.bottom, 12)
    }
    
    @ViewBuilder
    var appStoreDescription: some View {
        HStack {
            Text("App Store 구매 안내")
                .font(.headline2())
            .foregroundColor(.label_700)
            .padding(.leading, 20)
            .padding(.bottom, 5)
            .padding(.top, 30)
            Spacer()
        }
        
        ForEach(0..<appStoreExplain.count, id: \.self) { index in
            HStack {VStack {
                Text("•")
                        .font(.body2())
                    .foregroundColor(.label_500)
                Spacer()
            }
                VStack(alignment: .leading){
                    HStack {
                        Text(appStoreExplain[index])
                            .font(.body2())
                            .foregroundColor(.label_500)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .padding(.leading, 20)
        }
    }
    
    @ViewBuilder
    var paymentButton: some View {
        Button {
            print("결제가 됩니다.")
        } label: {
            FloatingButton(backgroundColor: .green_main) { Text("구독하기")
                    .foregroundColor(.gray_900)
                    .font(.button1())
                }
        }
    }
}

struct SelectedPaymentButton: View {
    var month: String
    var price: String
    var discountedPrice: String?
    @Binding var paymentSelected: Bool
    var discounted: Bool
//    @ViewBuilder let content: Content?
    
    var body: some View {
            Rectangle()
                            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(80))
                            .foregroundColor(paymentSelected ? Color.green_10 : Color.gray_900)
                            .cornerRadius(8)
                            .overlay{
                                HStack{
                                    Text(month)
                                    Spacer()
                                    Text(price+"원")
                                }
                                .foregroundColor(.label_900)
                                .font(.headline1())
                                .padding(20)
                                .foregroundColor(.white)
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(paymentSelected ? .green_main : .label_500)
            
                            }
                            .padding(.bottom, 12)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
