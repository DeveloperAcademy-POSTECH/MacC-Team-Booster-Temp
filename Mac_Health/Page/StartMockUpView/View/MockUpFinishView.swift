//
//  MockUpFinishView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/13/23.
//

import SwiftUI

struct MockUpFinishView: View {
    
//    @ObservedObject var viewModel: MockUpStopwatchViewModel
    @Binding var elapsedTime: TimeInterval
    @Binding var tabSelection: Int
    @Environment(\.dismiss) var dismiss: DismissAction
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack (spacing: 0) {
                Spacer()
                    .frame(height: UIScreen.getHeight(80))
                Image("finishIcon")
                    .frame(width: UIScreen.getWidth(276), height: UIScreen.getHeight(152))
                Image("finishInfluencer")
                    .resizable()
                    .frame(width: UIScreen.getWidth(294), height: UIScreen.getHeight(128))
                RoundedRectangle(cornerRadius: 8.0)
                    .frame(width: UIScreen.getWidth(294), height: UIScreen.getHeight(100))
                    .foregroundColor(.gray_700)
                    .overlay{
                        VStack(spacing: 5){
                            Text(getNowDateTime())
                                .font(.title1())
                                .foregroundColor(.label_900)
                            Text("오늘도 고생 많으셨어요!")
                                .font(.body())
                                .foregroundColor(.label_900)
                        }
                    }
                    .padding(.bottom, 30)
                HStack(spacing: 40){
                    VStack(spacing: 3){
                        Text("\(String(timeFormatted(elapsedTime)))")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("운동시간")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                    VStack(spacing: 3){
                        Text("580kcal")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("소모칼로리")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                    VStack(spacing: 3){
                        Text("9840kg")
                            .font(.title2())
                            .foregroundColor(.label_900)
                        Text("총 볼륨")
                            .font(.body2())
                            .foregroundColor(.label_700)
                    }
                }
                Spacer()
                    .frame(height: 115)
                Button{
                    appState.rootViewId = UUID()
                } label: {
                    FloatingButton(backgroundColor: .green_main) { Text("기록 확인")
                            .foregroundColor(.gray_900)
                            .font(.button1())
                    }
                    .padding(.bottom, 12)
                }
                
                Button{
                    print("move to login view")
                    
                } label: {
                    FloatingButton(backgroundColor: .gray_600) {
                            Text("로그인")
                        .foregroundColor(.green_main)
                        .font(.button1())
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
    
    func getNowDateTime() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:  "ko")
        
        dateFormatter.dateFormat = "yy.MM.dd"
        let date_String = dateFormatter.string(from: nowDate)
        return date_String
    }
    
    private func timeFormatted(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60
        return if hours >= 1 {
            String(format: "%01d시간%02d분",hours, minutes)
        } else {
            String(format: "%01d분", minutes)
        }
    }
}

//#Preview {
//    MockUpFinishView(elapsedTime: .constant(1.0), tabSelection: .constant(1))
//}
