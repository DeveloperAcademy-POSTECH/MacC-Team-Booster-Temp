//
//  EmptyCheckButton.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct EmptyCheckButton: View {
    var body: some View {
        Ellipse()
            .frame(width: UIScreen.getWidth(36), height: UIScreen.getHeight(36))
            .foregroundColor(.clear)
    }
}

struct EmptyCheckButton_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCheckButton()
    }
}
