//
//  WorkoutCell.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

struct WorkoutCell: View {
    let exercise: Exercise
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: exercise.exerciseImageUrl))
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.label_400)
            VStack(alignment: .leading) {
                Text(exercise.name)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                //                Text("3세트 | 10-15 reps")
                // TODO: 10-15 reps
                Text("\(exercise.numberOfSet) 세트")
                    .foregroundColor(.label_400)
                    .font(.body2())
            }
            .padding()
            Spacer()
        }
        .frame(width: UIScreen.getWidth(350))
    }
}

struct WorkoutCellView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutCell(exercise: Exercise(id: 0, name: "", exerciseImageUrl: "", numberOfSet: 0))
    }
}
