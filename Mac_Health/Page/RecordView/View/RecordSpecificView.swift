//
//  RecordSpecificView.swift
//  Mac_Health
//
//  Created by 최진용 on 11/5/23.
//

import SwiftUI

struct RecordSpecificView: View {
    let record: Records
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    RoutineDescriptionCard
                    Divider()
                    RoutineCell()
                    RoutineCell()
                }
            }
            .padding()
        }
        // TODO: 타이틀 폰트 체크
        .navigationBarTitle(formatForDate(from: record.date), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
            ToolbarItem(placement: .topBarTrailing) {
                //login 되야 활성화
                EditButton
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func formatForDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY년 MM월 dd일"
        dateFormatter.timeZone = TimeZone(identifier: "ko-KR")
        dateFormatter.locale = Locale(identifier: "ko-KR")
        
        return dateFormatter.string(from: date.toDate() ?? Date())
    }
    
    var RoutineDescriptionCard: some View {
        VStack(alignment: .leading, spacing: UIScreen.getWidth(10)) {
            // TODO: 인플루언서 네임
            Text(record.influencerName)
                .font(.title2())
                .foregroundColor(.label_900)
            // TODO: 폰트
            Text("2023년 4월 23일 루틴")
                .font(.caption())
                .foregroundColor(.label_700)
                .padding(.bottom, 10)
            Description(image: "figure.arms.open", text: record.part)
            Description(image: "square.stack.fill", text: "\(record.numberOfExercise)개")
            // TODO: 한 시간 넘어가면 어떻게 되는지 묻기
            Description(image: "clock.fill", text: "50분")
            Description(image: "flame.circle.fill", text: "\(record.burnedKCalories)kcal")
            // TODO: 총 무게
            Description(image: "dumbbell.fill", text: "13400kg")
        }.padding(.bottom, 15)
    }
    
    func Description(image: String, text: String) -> some View {
        HStack {
            Image(systemName: image)
                .foregroundColor(.label_700)
                .font(.body2())
                .frame(width: UIScreen.getWidth(20), alignment: .center)
                .padding(.trailing, 3)
            Text(text)
                .foregroundColor(.label_900)
                .font(.body())
        }
        .padding(.bottom, 5)
    }
    
    var EditButton: some View {
        NavigationLink {
            RecordEditView()
        } label: {
            Image(systemName: "pencil")
                .foregroundColor(.label_700)
                .font(.headline1())
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
        var body: some View {
            VStack {
                HStack {
                    Text("클로즈 그립 랫풀다운")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                    Spacer()
                    Text("1450kg")
                        .font(.headline1())
                        .foregroundColor(.label_900)
                }
                .font(.headline1())
                .foregroundColor(.label_900)
                .padding(.vertical)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 3) {
                        makeSet(id: 1, kg: 40, rep: 10)
                        makeSet(id: 1, kg: 40, rep: 10)
                        makeSet(id: 1, kg: 40, rep: 10)
                        makeSet(id: 1, kg: 40, rep: 10)
                    }
                }
            }
            .padding(.trailing, 5)
            .padding(.bottom)
        }
        
        func makeSet(id: Int, kg: Int, rep: Int) -> some View {
            HStack(spacing: 1) {
                Text("\(id)세트")
                    .frame(width: UIScreen.getWidth(50), alignment: .trailing)
                Text("\(kg)kg")
                    .frame(width: UIScreen.getWidth(40), alignment: .trailing)
                Image(systemName: "multiply")
                    .frame(width: UIScreen.getWidth(15), alignment: .trailing)
                    .foregroundColor(.label_400)
                Text("\(rep)회")
                    .frame(width: UIScreen.getWidth(27), alignment: .trailing)
            }
            .font(.body2())
            .foregroundColor(.label_700)
        }
    }
}

//struct RecordSpecificView_Preview: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            RecordSpecificView(record: Records(date: "", time: "", part: "", numberOfExercise: 5, burnedKCalories: 5, requiredMinutes: 5, exercises: []))
//        }
//    }
//}
