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
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var introduce = "한국인 최초로 북미에서 열리는 프로쇼 우승 (텍사스 프로, 2023.8.18)"
    //배열로 빼서 불렛별로 줄 맞출지 추후 수정 예정
    var award: Array = [
        "2023년 TEXAS PRO SHOW MEN'S CLASSIC PHYSIQUE 1위",
        "2022년 MR.Olympia 클래식 피지크 15위",
        "2022년 MONSTERZYM CLASSIC PHYSIQUE PRO 1위",
        "2021년 AGP CLASSIC PHYSIQUE PRO 4위",
        "2020년 아마추어 올림피아 부산 CLASSIC PHYSIQUE CLASS B 1위",
    ]
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            ScrollView {
                VStack{
                //구독 페이지 설명
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
                //구독 버튼
                subscribeButton
                //인플루언서 설명
                    VStack(alignment: .leading){
                        Text("소개")
                            .foregroundColor(.label_900)
                            .font(.headline1())
                            .padding(.top, 20)
                        Text(introduce)
                            .foregroundColor(.label_800)
                            .font(.body)
                            .padding(.bottom, 20)
                        Text("수상경력")
                            .foregroundColor(.label_900)
                            .font(.headline1())
                    }
                    
                if seeMore == false {
                    ZStack(alignment: .bottom){
                        VStack(alignment: .leading){
                            ForEach(0..<award.count, id: \.self) { index in
                                HStack {VStack {
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
                            .mask(
                            Rectangle()
                                .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(80)))
                        }
                        .padding(.leading, 20)
                        Image("seeMoreGradient")
                            .resizable()
                            .scaledToFit()
                        Button {
                            seeMore = true
                        } label: {
                            Text("더보기")
                                .font(.headline1())
                                .foregroundColor(Color.label_900)
                        }
                        .offset(y: 10)
                        
                    }
                    .frame(width: UIScreen.getWidth(384), height: UIScreen.getHeight(150))
                    .padding()
                }
                else {
                    VStack(alignment: .leading){
                        ForEach(0..<award.count, id: \.self) { index in
                            HStack {VStack {
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
                            .padding(.leading, 20)
                        }
                    }
                    .padding()
                }
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
        
        var BackButton: some View {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.label_900)
                    .font(.body())
            }
        }
        
        
    
    var subscribeButton: some View {
        NavigationLink {
            
        } label: {
            FloatingButton(backgroundColor: .green_main) { Text("구독하기")
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
