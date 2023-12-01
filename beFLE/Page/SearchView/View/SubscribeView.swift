//
//  SubscribeView.swift
//  beFLE
//
//  Created by 정회승 on 2023/10/21.
//

import SwiftUI

struct SubscribeView: View {
    let influencerId: Int
    
    @StateObject var vm = SubscribeViewModel()
    
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
        "미스터 스누 23 관악 2위"
    ]
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            ScrollView {
                VStack {
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
                            vm.showTab = true
                        } else  {
                            vm.showTab = false
                        }
                    }
                    vm.scrollOffset = offset
                }
            }
            .coordinateSpace(name: "scroll")
            .overlay(
                vm.showTab ?
                createTab() : nil, alignment: Alignment.bottom
            )
        }
        .onAppear {
            vm.fetchInfluencer(influencerId: influencerId)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }
        .gesture(
            DragGesture().onChanged { value in
                if value.startLocation.x < 50 {
                    vm.offset = value.translation.width
                }
            }
                .onEnded { value in
                    if value.predictedEndTranslation.width > 100 {
                        dismiss()
                    }
                    vm.offset = .zero
                }
        )
        .offset(x: vm.offset)
        .animation(.easeInOut)
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    var IntroPage: some View {
        VStack{
//            topBackground
            TabView {
                ForEach(Array(vm.influencer.carouselImageUrls), id: \.self) { imageUrl in
                    ZStack {
                        LoadingImage(url: imageUrl)
                            .frame(width: UIScreen.getWidth(390), height: UIScreen.getHeight(358))
                        
                        LinearGradient(colors: [.gray_900, .clear, .clear, .gray_900.opacity(0.7), .gray_900], startPoint: .top, endPoint: .bottom)
                    }
                }
            }
            .tabViewStyle(.page)
            .frame(width: UIScreen.getWidth(390), height: UIScreen.getHeight(358))
            topInfluencerDescription
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_900)
                .font(.headline2())
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
                        .padding(.top, 30)
                    Spacer()
                }
                Text(vm.influencer.introduce)
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
                ForEach(0..<vm.seperateAward(input: vm.influencer.awards).count, id: \.self) { index in
                    HStack {
                        VStack {
                            Text("•")
                                .font(.body)
                                .foregroundColor(.label_800)
                            Spacer()
                        }
                        VStack(alignment: .leading){
                            HStack {
                                Text(vm.seperateAward(input: vm.influencer.awards)[index])
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
            //            }
        }
    }
    
    
    @ViewBuilder
    var subscribeButton: some View {
            Button {
                vm.influencer.isSubscription ? vm.unSubscribeInfluecer(influencerId: influencerId) : vm.subscribeInfluecer(influencerId: influencerId)
            } label: {
                FloatingButton(size: .medium, color: vm.influencer.isSubscription ? .gray_600 : .green_main) {
                    vm.influencer.isSubscription ?
                    Text("구독취소")
                        .foregroundColor(.red_main)
                        .font(.button1())
                    :
                    Text("구독")
                        .foregroundColor(.gray_900)
                        .font(.button1())
                }
            }
            .alert(vm.influencer.isSubscription ? "구독이 완료되었습니다." : "구독이 취소되었습니다.", isPresented: $vm.isSubscriptionAlertShow) {
                Button("확인") {
                    //TODO: 서버에 vm.routines.routines 변화
                    dismiss()
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
                    VStack(alignment: .leading) {
                        Text("\(vm.influencer.influencerName)의 \(vm.influencer.routineName)")
                            .foregroundColor(.label_900)
                            .font(.title1())
                            .padding(.bottom, 3)
                        Text(vm.influencer.title)
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
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("신체정보")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                Text("키: \(vm.influencer.bodySpec.height)cm")
                    .foregroundColor(.label_800)
                    .font(.body())
                Text("몸무게: \(vm.influencer.bodySpec.weight)kg")
                    .foregroundColor(.label_800)
                    .font(.body())
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    var strengthInformation: some View {
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("3대 중량")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .padding(.top, 20)
                    .padding(.bottom, 12)
                Text("Squat: \(vm.influencer.bigThree.squat)kg")
                    .foregroundColor(.label_800)
                    .font(.body())
                Text("Deadlift: \(vm.influencer.bigThree.deadLift)kg")
                    .foregroundColor(.label_800)
                    .font(.body())
                Text("Bench Press: \(vm.influencer.bigThree.benchPress)kg")
                    .foregroundColor(.label_800)
                    .font(.body())
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct WorkoutExplain: View {
    let ImageName: String
    let WorkoutName: String
    let SetCount: String
    let part: String
    
    var body: some View {
        HStack{
            Image(ImageName)
                .resizable()
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .background{
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(.fill_1)
                        .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                }
            VStack(alignment: .leading){
                Text(WorkoutName)
                    .font(.headline1())
                    .foregroundColor(.label_900)
                HStack{
                    Text(SetCount)
                        .font(.body2())
                        .foregroundColor(.label_700)
                    Rectangle()
                        .frame(width:1, height: 10)
                        .foregroundColor(.label_400)
                    Text(part)
                        .font(.body2())
                        .foregroundColor(.label_700)
                    
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

//struct SubscribeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubscribeView()
//    }
//}
