//
//  MockUpRecordExampleView.swift
//  Mac_Health
//
//  Created by 정회승 on 11/17/23.
//

import SwiftUI

struct MockUpRecordExampleView: View {
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
        .navigationBarTitle(record.date, displayMode: .inline)
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
            // TODO: 인플루언서 네임
            Text("")
            // TODO: 폰트
            Text("2023년 4월 23일 루틴")
            Description(image: "figure.arms.open", text: record.part)
            Description(image: "square.stack.fill", text: "\(record.numberOfExercise)개")
            // TODO: 한 시간 넘어가면 어떻게 되는지 묻기
            Description(image: "clock.fill", text: "50분")
            Description(image: "flame.circle.fill", text: "\(record.burnedKCalories)kcal")
            // TODO: 총 무게
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
                    Text("1450kg")
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

#Preview {
    MockUpRecordExampleView(record: <#Records#>)
}
