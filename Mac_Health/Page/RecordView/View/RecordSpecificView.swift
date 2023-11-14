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
            ///날짜는 상위뷰에서 받아와야함
        }.navigationBarTitle("2203년 6월 23일", displayMode: .inline)
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
    
    var RoutineDescriptionCard: some View {
        VStack(alignment: .leading, spacing: UIScreen.getWidth(14)) {
            Text("정회승")
            Text("2023년 4월 23일 루틴")
            Description(image: "figure.arms.open", text: "등 이두")
            Description(image: "square.stack.fill", text: "7개")
            Description(image: "clock.fill", text: "50분")
            Description(image: "flame.circle.fill", text: "569kcal")
            Description(image: "dumbbell.fill", text: "13400kg")
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
                    Spacer()
                    Text("1450 kg")
                }
                .font(.headline1())
                .foregroundColor(.label_900)
                .padding(.vertical)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 6) {
                        makeSet(id: 1, kg: 40, rep: 10)
                        makeSet(id: 1, kg: 40, rep: 10)
                        makeSet(id: 1, kg: 40, rep: 10)
                        makeSet(id: 1, kg: 40, rep: 10)
                    }
                }
            }
        }
        func makeSet(id: Int, kg: Int, rep: Int) -> some View {
            HStack(spacing: 16) {
                Text("\(id)세트")
                Text("\(kg)kg")
                Text("\(rep)회")
            }
            .font(.body2())
            .foregroundColor(.label_700)
        }
    }
    
}

struct RecordSpecificView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            RecordSpecificView(record: Records(date: "", time: "", part: "", numberOfExercise: 5, burnedKCalories: 5, requiredMinutes: 5, exercises: []))
        }
    }
}
