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
                    ForEach(record.exercises, id: \.self) { exercises in
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
            Description(image: "dumbbell.fill", text: "\(vm.caculatelTotalVolume(workouts: record.exercises))kg")
        }
        .padding(.bottom, 15)
    }
    
    func RoutineCell(exercises: RecordedExercise) -> some View {
        VStack {
            HStack {
                Text(exercises.name)
                    .font(.headline1())
                    .foregroundColor(.label_900)
                Spacer()
                Text("\(vm.caculateVolume(sets: exercises.sets))kg")
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
                        MakeSet(id: index + 1, kg: exercises.sets[index].weight, rep: exercises.sets[index].reps)
                    }
                }
            }
        }
        .padding(.trailing, 5)
        .padding(.bottom)
    }
    
    func MakeSet(id: Int, kg: Int? = nil, rep: Int) -> some View {
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
