//
//  MockUpSubscribeView.swift
//  beFLE
//
//  Created by 정회승 on 11/15/23.
//

import SwiftUI

struct MockUpSubscribeView: View {
    @State var showTab = false
    @State var scrollOffset: CGFloat = 0.00
    @State var subscribingSheet = false
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var introduce = """
안녕하세요! 운동하는 개발자 정회승입니다🐵
여러분과 함께 운동하기 위해
제 운동일지를 공유하게 되었습니다
"""
    var award: Array = [
        "Wngp 서울 클래식피지크 체급 1위",
        "Wngp 서울 보디빌딩 체급 1위",
        "Wngp 서울 클래식피지크 그랑프리 2위",
        "Wngp 서울 보디빌딩 그랑프리 3위",
        "Npc 내츄럴 보디빌딩 오픈 4위",
        "Npc 내츄럴 클래식피지크 노비스 1위",
        "미스터 스누 22 연건 1위",
        "미스터 스누 23 관악 2위"
    ]
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            ScrollView {
                VStack {
                    IntroPage
                    topInfluencerDescription
                    subscribeButton
                    introInfluencer
                    bodyInformation
                    strengthInformation
                    RoutinePreview()
                        .padding(.horizontal)
                }
                .background(GeometryReader { geo in
                    return Color.clear.preference(key: ViewOffsetKey.self, value: -geo.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    withAnimation {
                        if offset > UIScreen.getHeight(422) {
                            showTab = true
                        } else {
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
        ZStack {
            TabView {
                ForEach(1...3, id: \.self) { _ in
                    ZStack {
                        Image("bannerImage")
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors: [.clear, .clear, .clear, .clear, .clear, .gray_900.opacity(0.5), .gray_900], startPoint: .top, endPoint: .bottom)
                    }
                }
            }
            .tabViewStyle(.page)
            .frame(width: UIScreen.getWidth(390), height: UIScreen.getHeight(358))
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline2())
        }
    }
    
    @ViewBuilder
    var introInfluencer: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("인사말")
                        .foregroundColor(.label_900)
                        .font(.headline1())
                        .padding(.top, 30)
                    Spacer()
                }
                Text(introduce)
                    .foregroundColor(.label_800)
                    .font(.body())
                    .padding(.top, 10)
                    .lineSpacing(8.0)
                Text("수상경력")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 30)
            }
            .padding(.top, 15)
            .padding(.leading)
            .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading) {
                ForEach(0..<award.count, id: \.self) { index in
                    HStack {
                        VStack {
                            Text("•")
                                .font(.body)
                                .foregroundColor(.label_800)
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text(award[index])
                                    .font(.body())
                                    .foregroundColor(.label_800)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .padding(.leading, 10)
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            .padding(.bottom, 5)
        }
    }

    @ViewBuilder
    var subscribeButton: some View {
        Button {
            LaunchViewModel.shared.previewLogin()
        } label: {
            FloatingButton(size: .medium, color: .green_main) {
                Text("로그인하고 구독하기")
                    .foregroundColor(.gray_900)
                    .font(.button1())
            }
        }
    }
    
    fileprivate func createTab() -> some View {
        return subscribeButton
            .padding(.bottom, 30)
            .transition(.scale)
    }
    
    var topInfluencerDescription: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("정회승의 Smart Routine")
                            .foregroundColor(.label_900)
                            .font(.title1())
                            .padding(.bottom, 3)
                        Text("2022 Mr. 서울대🏆")
                            .foregroundColor(.label_600)
                            .font(.body2())
                            .padding(.bottom, 20)
                    }
                    Spacer()
                }
                .padding(.vertical, 5)
                .padding(.leading, 20)
            }
        }
    }
    
    var bodyInformation: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("신체정보")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                Text("키: 173cm")
                    .foregroundColor(.label_800)
                    .font(.body())
                Text("몸무게: 80kg")
                    .foregroundColor(.label_800)
                    .font(.body())
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    var strengthInformation: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("3대 중량")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
                    .padding(.bottom, 12)
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
        .padding(.bottom, 10)
    }
}

struct RoutinePreview: View {
    var date: String = "2023년 10월 15일"
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Divider()
                            .foregroundColor(.fill_1)
                            .padding(.top)
                        Text("운동일지 미리보기")
                            .font(.title2())
                            .foregroundColor(.label_900)
                            .padding(.top, 30)
                        HStack {
                            Text(date)
                                .font(.body2())
                                .foregroundColor(.label_700)
                            Rectangle()
                                .frame(width: 1, height: 10)
                                .foregroundColor(.label_400)
                            Text("등, 이두")
                                .font(.body2())
                                .foregroundColor(.label_700)
                        }
                    }
                    .padding(.top, 20)
                    Spacer()
                }
                HStack {
                    Text("등")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.vertical, 20)
                    Spacer()
                }
                
                WorkoutExplain(ImageName: "hyperExtention", WorkoutName: "하이퍼 익스텐션", SetCount: "3세트", part: "등")
                HStack(alignment: .top) {
                    Image("descriptionFace1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.getWidth(48))
                        .padding(10)
                    VStack(alignment: .leading) {
                        Text("운동 팁 예시")
                            .font(.body2())
                            .foregroundColor(.label_500)
                            .padding(.bottom, 5)
                        Text("운동 전 기립근의 부하를 줄여 줄 수 있는 하이퍼 익스텐션입니다. 등의 일직선 상에 위치 할 수 있도록 하시고, 고개를 과도하게 숙이거나 올리지 않도록 합니다. 스트레칭하듯 수행해 주세요.")
                            .font(.body())
                            .foregroundColor(.label_900)
                            .lineSpacing(5)
                    }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                }
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.gray_700)
                }
                .padding(.vertical, 10)
                
                WorkoutExplain(ImageName: "dumbellPullOver", WorkoutName: "덤벨 풀 오버", SetCount: "4세트", part: "등")
                WorkoutExplain(ImageName: "barbellRow", WorkoutName: "바벨 로우", SetCount: "4세트", part: "등")
                    .padding(.bottom, 3)
                HStack {
                    Text("이두")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(.vertical, 20)
                    Spacer()
                }
                WorkoutExplain(ImageName: "CloseGripLatPullDown", WorkoutName: "케이블 해머 컬", SetCount: "3세트", part: "이두")
            }
            .padding(.bottom, 30)
            VStack {
                Spacer()
                LinearGradient(colors: [.clear, .clear, .clear, .clear, .gray_900.opacity(0.5), .gray_900], startPoint: .top, endPoint: .bottom)
            }
        }
    }
}
