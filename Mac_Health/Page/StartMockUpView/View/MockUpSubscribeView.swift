//
//  MockUpSubscribeView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/15/23.
//

import SwiftUI

struct MockUpSubscribeView: View {
    
    @State var showTab = false
    @State var scrollOffset: CGFloat = 0.00
    @State var subscribingSheet = false
    @State var loggedIn: Bool = true
    @Binding var tabSelection: Int
    @Binding var subscribed: Bool
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var introduce = """
안녕하세요! 운동하는 개발자 정회승입니다🐵
여러분과 함께 운동하기 위해
제 운동일지를 공유하게 되었습니다
"""
    //배열로 빼서 불렛별로 줄 맞출지 추후 수정 예정
    var award: Array = [
        "Wngp 서울 클래식피지크 체급 1위",
        "Wngp 서울 보디빌딩 체급 1위",
        "Wngp 서울 클래식피지크 그랑프리 2위",
        "Wngp 서울 보디빌딩 그랑프리 3위",
        "Npc 내츄럴 보디빌딩 오픈 4위",
        "Npc 내츄럴 클래식피지크 노비스 1위",
        "미스터 스누 22 연건 1위",
        "미스터 스누 23 관악 2위",
    ]
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            ScrollView {
                VStack{
                    //구독 페이지 설명
                    IntroPage
                    //구독 버튼
                    subscribeButton
                    //인플루언서 설명
                    introInfluencer
                    bodyInformation
                    strengthInformation
                    //루틴 미리보기
                    RoutinePreview()
                        .padding(.horizontal)
                }
                .background(GeometryReader {
                    return Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    withAnimation {
                        if offset > UIScreen.getHeight(422) {
                            showTab = true
                        } else  {
                            showTab = false
                        }
                    }
                    scrollOffset = offset
                }
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                showTab ?
                createTab() : nil, alignment: Alignment.bottom
            )
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    var IntroPage: some View {
        ZStack{
            topBackground
            TabView {
                ForEach(1...3, id: \.self) { idx in
                    //둘러보기에서 구독 뷰
                    ZStack{
                        Image("RotateInfluencer\(idx)")
                            .resizable()
                            .scaledToFit()
                        LinearGradient(colors: [.gray_900,.clear, .clear, .gray_900.opacity(0.7), .gray_900], startPoint: .top, endPoint: .bottom)
                    }
                }
            }
            .tabViewStyle(.page)
            topInfluencerDescription
            
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_900)
                .font(.body())
        }
    }
    
    @ViewBuilder
    var introInfluencer: some View {
        VStack{
            VStack(alignment: .leading){
                HStack {
                    Text("인사말")
                        .foregroundColor(.label_900)
                        .font(.headline1())
                        .padding(.top, 20)
                    Spacer()
                }
                Text(introduce)
                    .foregroundColor(.label_800)
                    .font(.body)
                    .padding(.vertical, 10)
                Text("수상경력")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
            }
            .padding(.leading)
            .frame(maxWidth: .infinity)
            //MARK: 잼이 지우지 말래요.
//            if seeMore == false {
//                ZStack(alignment: .top){
//                    VStack(alignment: .leading){
//                        ForEach(0..<award.count, id: \.self) { index in
//                            HStack{
//                                VStack{
//                                    Text("•")
//                                        .font(.body)
//                                        .foregroundColor(.label_800)
//                                    Spacer()
//                                }
//                                VStack(alignment: .leading){
//                                    HStack{
//                                        Text(award[index])
//                                            .font(.body)
//                                            .foregroundColor(.label_800)
//                                        Spacer()
//                                    }
//                                    Spacer()
//                                }
//                            }
//                            .padding(.leading, 10)
//                        }
//                    }
//                    .mask(alignment: .top){
//                        Rectangle()
//                            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(130))
//                    }
//                    .padding()
//                    LinearGradient(colors: [.clear, .clear, .gray_900.opacity(0.7), .gray_900], startPoint: .top, endPoint: .bottom)
//                    Button {
//                        seeMore = true
//                    } label: {
//                        VStack{
//                            Spacer()
//                                .frame(height: UIScreen.getHeight(170))
//                            Text("더보기")
//                                .font(.headline1())
//                                .foregroundColor(Color.label_900)
//                        }
//                    }
//
//                }
//                .frame(width: UIScreen.getWidth(384), height: UIScreen.getHeight(150))
//                .padding(.top, 40)
//            }
//            else {
                VStack(alignment: .leading){
                    ForEach(0..<award.count, id: \.self) { index in
                        HStack {
                            VStack {
                                Text("•")
                                    .font(.body)
                                    .foregroundColor(.label_800)
                                Spacer()
                            }
                            VStack(alignment: .leading){
                                HStack {
                                    Text(award[index])
                                        .font(.body)
                                        .foregroundColor(.label_800)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                        .padding(.leading, 10)
                    }
                }
                .padding()
//            }
        }
    }
    
    
    @ViewBuilder
    var subscribeButton: some View {
        FloatingButton(backgroundColor: .gray_600) {Text("둘러보기 중")
                        .foregroundColor(.label_400)
                        .font(.button1())
                }
                
            
        }
    
    fileprivate func createTab() -> some View {
        return subscribeButton
            .padding(.bottom, 30)
            .transition(.scale)
    }
    
    var topInfluencerDescription: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading, spacing: 16){
                        Text("정회승의 Smart Routine")
                            .foregroundColor(.label_900)
                            .font(.title1())
                        Text("2022 Mr. 서울대🏆")
                            .foregroundColor(.label_600)
                            .font(.body2())
                            .padding(.bottom, 40)
                    }
                    Spacer()
                }
                .padding(.leading, 20)
            }
        }
        .frame(height: UIScreen.getHeight(358))
    }
    
    var bodyInformation: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("신체정보")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                Text("키: 173cm")
                    .foregroundColor(.label_800)
                    .font(.body)
                Text("몸무게: 80kg")
                    .foregroundColor(.label_800)
                    .font(.body)
            }
         Spacer()
        }
        .padding(.horizontal)
    }
    
    var strengthInformation: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("3대 중량")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                Text("Squat: 210kg")
                    .foregroundColor(.label_800)
                    .font(.body)
                Text("Deadlift: 280kg")
                    .foregroundColor(.label_800)
                    .font(.body)
                Text("Bench Press: 140kg")
                    .foregroundColor(.label_800)
                    .font(.body)
            }
         Spacer()
        }
        .padding(.horizontal)
    }
    
    var topBackground: some View {
        ZStack(alignment: .bottomTrailing){
            Color.gray_900.ignoresSafeArea()
            HStack{
                Spacer()
                Image("Background1")
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(height: UIScreen.getHeight(358))
        
    }
    
}


//#Preview {
//    MockUpSubscribeView()
//}
