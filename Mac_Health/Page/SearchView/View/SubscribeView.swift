//
//  SubscribeView.swift
//  Mac_Health
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct SubscribeView: View {
    
    @State var seeMore:Bool = false
    @State var showTab = false
    @State var scrollOffset: CGFloat = 0.00
    @State var subscribingSheet = false
    @State var subscribed = true
    @State var loggedIn = true
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
                //루틴 미리보기
                RoutinePreview(previewRoutine: previewRoutine[0])
                    .padding(.horizontal, 10)
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
        .navigationBarBackButtonHidden(true)
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
        
    if seeMore == false {
        ZStack(alignment: .top){
            VStack(alignment: .leading){
                ForEach(0..<award.count, id: \.self) { index in
                    HStack{
                        VStack{
                        Text("•")
                                .font(.body)
                            .foregroundColor(.label_800)
                        Spacer()
                    }
                        VStack(alignment: .leading){
                            HStack{
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
            .mask(
            Rectangle()
                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(230)))
            .padding()
            LinearGradient(colors: [.clear, .clear, .gray_900.opacity(0.7), .gray_900], startPoint: .top, endPoint: .bottom)
            Button {
                seeMore = true
            } label: {
                VStack{
                    Spacer()
                        .frame(height: UIScreen.getHeight(170))
                    Text("더보기")
                        .font(.headline1())
                        .foregroundColor(Color.label_900)
                }
            }
            
        }
        .frame(width: UIScreen.getWidth(384), height: UIScreen.getHeight(150))
    }
    else {
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
    }
    }
        
        
    
    var subscribeButton: some View {
        Button {
            self.subscribingSheet = true
            self.subscribed.toggle()
        } label: {
            FloatingButton(backgroundColor: subscribed ? .green_main : .gray_900) { subscribed ? Text("구독")
                    .foregroundColor(.gray_900)
                    .font(.button1())
                :
                Text("구독 취소")
                    .foregroundColor(.red_main)
                    .font(.button1())
            }

        }
        .alert(isPresented: $subscribingSheet) {
            loggedIn ?
            subscribed ?
            Alert(
                title: Text("구독이 취소되었습니다."),
                message: Text(""),
                dismissButton: .destructive(Text("확인"),
                                        action: {
                                            //구독 취소
                                            
                                })
            ) :
            Alert(
                title: Text("구독이 완료되었습니다."),
                message: Text(""),
                dismissButton: .destructive(Text("확인"),
                                        action: {
                                            //구독 완료
                                            
                                })
            )
            :
            Alert(
                title: Text("로그인이 필요합니다."),
                message: Text(""),
                primaryButton: .destructive(Text("확인"),
                                        action: {
                                            //로그인 뷰 이동
                                            
                                }),
                                secondaryButton: .cancel(Text("취소"))
            )
            
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

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct RoutinePreview: View {
    //날짜 변환
    var date: String = "2023년 10월 15일"
    var part: String = "등/가슴"
    var firstPart = "등"
    var secondPart = "가슴"
    let previewRoutine: PreviewRoutine
    
    var body: some View {
        ZStack{
            Color.gray_900.ignoresSafeArea()
            VStack {
                HStack{
                    VStack(alignment: .leading){
                        Text("루틴 미리보기")
                            .font(.title2)
                            .foregroundColor(.label_900)
                        HStack{
                            Text(date)
                                .font(.headline2())
                                .foregroundColor(.label_700)
                            Rectangle()
                                .frame(width:1, height: 10)
                                .foregroundColor(.label_400)
                            Text(part)
                                .font(.headline2())
                                .foregroundColor(.label_700)
                            
                        }
                    }
                    .padding(20)
                    Spacer()
                }
                HStack{
                    Text(firstPart)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(20)
                    Spacer()
                }
                //운동 루틴
                WorkoutExplain
                //첫 운동 팁 설명
                //ZStack{
                HStack(alignment: .top){
                    Image("descriptionFace1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.getWidth(48))
                        .padding(10)
                    VStack(alignment: .leading){
                        Text("운동 팁 예시")
                            .font(.body2())
                            .foregroundColor(.label_500)
                            .padding(.bottom, 5)
                        
                        Text(previewRoutine.exerciseTip!)
                            .font(.body)
                            .foregroundColor(.label_900)
                    }
                    .padding(.vertical, 10)
                }
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.gray_700)
                    }
                    .padding(20)
//                }
                WorkoutExplain
                //부위별 다른지 체크
                HStack{
                    Text(secondPart)
                        .font(.headline1())
                        .foregroundColor(.label_900)
                        .padding(20)
                    Spacer()
                }
                WorkoutExplain
                WorkoutExplain
                
            }
            .padding(.bottom, 30)
            VStack{
                Spacer()
                Image("previewGradient")
                    .resizable()
                    .scaledToFit()
            }
        }
        
    }
    
    @ViewBuilder
    var WorkoutExplain: some View {
        HStack{
            Image("CloseGripLatPullDown")
                .resizable()
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .padding(.leading, 20)
            VStack(alignment: .leading){
                Text("클로즈 그립 랫 풀 다운")
                    .font(.headline1())
                    .foregroundColor(.label_900)
                HStack{
                    Text("3세트")
                        .font(.headline2())
                        .foregroundColor(.label_700)
                    Rectangle()
                        .frame(width:1, height: 10)
                        .foregroundColor(.label_400)
                    Text(part)
                        .font(.headline2())
                        .foregroundColor(.label_700)
                    
                }
            }
            .padding(.leading, 10)

            Spacer()
        }
    }
}

struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeView()
    }
}
