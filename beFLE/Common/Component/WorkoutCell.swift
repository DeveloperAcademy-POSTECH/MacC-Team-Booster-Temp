//
//  WorkoutCell.swift
//  beFLE
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

struct WorkoutCell: View {
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 1){
            RoundedRectangle(cornerRadius: 4)
                .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.fill_1)
                .overlay {
                    AsyncImage(url: URL(string: exercise.exerciseImageUrl ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        LottieView()
                            .padding(5)
                    }
                }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(exercise.name)
                    .foregroundColor(.label_900)
                    .font(.headline1())
                    .multilineTextAlignment(.leading)
                    .allowsTightening(true)
                HStack(spacing: 3){
                    Text("\(exercise.numberOfSet)세트")
                        .foregroundColor(.label_700)
                        .font(.body2())
                    Text("|")
                        .font(.body2())
                        .foregroundColor(.label_400)
                        .scaleEffect(0.8)
                    Text("\(exercise.recommendReps)회")
                        .foregroundColor(.label_700)
                        .font(.body2())
                }
            }
            .padding()
            Spacer()
        }
        .frame(width: UIScreen.getWidth(350))
    }
}

struct WorkoutCellView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutCell(exercise: Exercise(id: 0, name: "", exerciseImageUrl: "", numberOfSet: 0, recommendReps: "", isDone: false))
    }
}
