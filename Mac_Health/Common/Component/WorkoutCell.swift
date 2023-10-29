//
//  WorkoutCell.swift
//  Mac_Health
//
//  Created by 최진용 on 2023/10/22.
//

import SwiftUI

struct WorkoutCell: View {
    var body: some View {
        HStack {
            Image("CloseGripLatPullDown")
                .resizable()
            .frame(width: UIScreen.getWidth(64), height: UIScreen.getHeight(64))
                .foregroundColor(.label_400)
            VStack(alignment: .leading) {
                Text("클로스 그립 렛풀다운")
                    .foregroundColor(.label_900)
                    .font(.headline1())
                Text("3세트 | 10-15 reps")
                    .foregroundColor(.label_400)
                    .font(.body2())
            }.padding()
            Spacer()
        }.frame(width: UIScreen.getWidth(350))
    }
}

struct WorkoutCellView_Preview: PreviewProvider {
    static var previews: some View {
        WorkoutCell()
    }
}
