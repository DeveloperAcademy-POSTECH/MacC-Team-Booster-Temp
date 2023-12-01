//
//  RecordSpecificView.swift
//  beFLE
//
//  Created by 최진용 on 11/5/23.
//

import SwiftUI

struct RecordSpecificView: View {
    let record: Records
    @StateObject var vm = RecordSpecificViewModel()
    
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var body: some View {
        ZStack {
            Color.gray_900.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    RoutineDescriptionCard
                    Divider()
                    ForEach(record.exercises, id: \.self){
                        exercises in
                        RoutineCell(exercises: exercises)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(record.finishDate.format(.yearMonthDay), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton
            }
        }
        .navigationBarBackButtonHidden(true)
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
    }
    
    var RoutineDescriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(record.influencerName)
                .font(.title2())
                .foregroundColor(.label_900)
                .padding(.bottom, 10)
            Text("\(record.uploadDate.format(.fullYearMonthDay)) 루틴")
                .font(.caption())
                .foregroundColor(.label_700)
                .padding(.bottom, 10)
            Description(image: "figure.arms.open", text: record.part)
            Description(image: "square.stack.fill", text: "\(record.numberOfExercise)개")
            Description(image: "clock.fill", text: "\(vm.timeFormat(from: record.time))")
            Description(image: "flame.circle.fill", text: "\(record.burnedKCalories)kcal")
            Description(image: "dumbbell.fill", text: "\(record.exercises.reduce(0, { $0 + $1.sets.reduce(0, { $0 + ($1.weight ?? 0) * $1.reps } )}))kg")
        }
        .padding(.bottom, 15)
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
        .padding(.bottom, 7)
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
}

struct RoutineCell: View {
    var exercises: RecordedExercise
    var body: some View {
        VStack {
            HStack {
                Text(exercises.name)
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                Text("\(exercises.sets.reduce(0, { $0 + ($1.weight ?? 0) * $1.reps }))kg")
                    .font(.headline1())
                    .foregroundColor(.label_900)
            }
            .font(.headline1())
            .foregroundColor(.label_900)
            .padding(.vertical)
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    ForEach(0..<exercises.sets.count, id: \.self) { index in
                        makeSet(id: index + 1, kg: exercises.sets[index].weight, rep: exercises.sets[index].reps)
                    }
                }
            }
        }
        .padding(.trailing, 5)
        .padding(.bottom)
    }
    
    func makeSet(id: Int, kg: Int? = nil, rep: Int) -> some View {
        HStack(spacing: 1) {
            Text("\(id)세트")
                .frame(minWidth: UIScreen.getWidth(50), alignment: .trailing)
            Text("\(kg == nil ? "자율" : "\(kg!)kg")")
                .frame(minWidth: UIScreen.getWidth(40), alignment: .trailing)
            Image(systemName: "multiply")
                .frame(minWidth: UIScreen.getWidth(15), alignment: .trailing)
                .foregroundColor(.label_400)
            Text("\(rep)회")
                .frame(minWidth: UIScreen.getWidth(30), alignment: .trailing)
        }
        .font(.body2())
        .foregroundColor(.label_700)
        .frame(minWidth: UIScreen.getWidth(135), alignment: .leading)
    }
}
