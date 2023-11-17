//
//  MockUpRecordExampleView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/17/23.
//

import SwiftUI

struct MockUpRecordExampleView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    RoutineDescriptionCard
                    Divider()
                        .padding(.vertical, 5)
                    RoutineCell(workoutName: "사이드 레터럴 레이즈", totalWeight: 840, setInfo: [[1,12,20],[2,10,20],[3,10,20],[4,10,20]])
                    RoutineCell(workoutName: "덤벨 숄더 프레스", totalWeight: 2100, setInfo: [[1,40,10],[2,60,10],[3,60,10],[4,50,10]])
                    RoutineCell(workoutName: "업 라이트 로우", totalWeight: 800, setInfo: [[1,20,10],[2,20,10],[3,20,10],[4,20,10]])
                    RoutineCell(workoutName: "인클라인 벤치 프레스", totalWeight: 3200, setInfo: [[1,60,10],[2,80,10],[3,100,10],[4,80,10]])
                    RoutineCell(workoutName: "펙 덱 플라이", totalWeight: 1750, setInfo: [[1,40,10],[2,45,10],[3,50,10],[4,40,10]])
                    RoutineCell(workoutName: "케이블 트라이셉스 익스텐션 ", totalWeight: 1250, setInfo: [[1,30,10],[2,35,10],[3,30,10],[4,30,10]])
                }
            }
            .padding(.horizontal)
            .padding(.top)
        }
        // TODO: 타이틀 폰트 체크
        .navigationBarTitle("운동 기록 예시", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var RoutineDescriptionCard: some View {
        VStack(alignment: .leading, spacing: UIScreen.getWidth(14)) {
            // TODO: 인플루언서 네임
            Text("정회승")
                .font(.title2())
                .foregroundColor(.label_900)
            // TODO: 폰트
            Text("2023년 4월 23일 루틴")
                .font(.caption())
                .foregroundColor(.label_700)
            Description(image: "figure.arms.open", text: "어깨, 가슴, 삼두")
            Description(image: "square.stack.fill", text: "6개")
            // TODO: 한 시간 넘어가면 어떻게 되는지 묻기
            Description(image: "clock.fill", text: "52분12초")
            Description(image: "flame.circle.fill", text: "430kcal")
            // TODO: 총 무게
            Description(image: "dumbbell.fill", text: "10040kg")
        }.padding(.bottom)
    }
    
    func Description(image: String, text: String) -> some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.label_700)
                .font(.body2())
                .frame(width: UIScreen.getWidth(30))
            Text(text)
                .foregroundColor(.label_900)
                .font(.body())
        }
    }
    
    var BackButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.label_700)
                .font(.headline1())
        }
    }
    
    struct RoutineCell: View {
        var workoutName: String
        var totalWeight: Int
        var setInfo: [[Int]]
        var body: some View {
            VStack {
                HStack {
                    Text(workoutName)
                    Spacer()
                    Text("\(totalWeight)kg")
                }
                .font(.headline1())
                .foregroundColor(.label_900)
                .padding(.vertical)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 6) {
                        makeSet(id: setInfo[0][0], kg: setInfo[0][1], rep: setInfo[0][2])
                        makeSet(id: setInfo[1][0], kg: setInfo[1][1], rep: setInfo[2][2])
                        makeSet(id: setInfo[2][0], kg: setInfo[2][1], rep: setInfo[2][2])
                        makeSet(id: setInfo[3][0], kg: setInfo[3][1], rep: setInfo[3][2])
                    }
                }
            }
        }
        
        func makeSet(id: Int, kg: Int, rep: Int) -> some View {
            HStack(spacing: 1) {
                Text("\(id)세트")
                    .frame(width: 50, alignment: .trailing)
                Text("\(kg)kg")
                    .frame(width: 50, alignment: .trailing)
                Image(systemName: "multiply")
                    .frame(width: 20, alignment: .trailing)
                    .foregroundColor(.label_400)
                Text("\(rep)회")
                    .frame(width: 36, alignment: .trailing)
            }
            .font(.body2())
            .foregroundColor(.label_700)
        }
    }
}

#Preview {
    MockUpRecordExampleView()
}
