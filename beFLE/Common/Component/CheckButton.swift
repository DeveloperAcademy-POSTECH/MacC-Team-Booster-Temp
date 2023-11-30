//
//  CheckButton.swift
//  beFLE
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct CheckButton: View {
    let status: Status
    
    enum Status {
        case empty
        case check
    }
    
    var body: some View {
        switch status {
        case .empty:
            Ellipse()
                .frame(width: UIScreen.getWidth(36), height: UIScreen.getHeight(36))
                .foregroundColor(.clear)
        case .check:
            Ellipse()
                .frame(width: UIScreen.getWidth(36), height: UIScreen.getHeight(36))
                .foregroundColor(.green_10)
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.headline2())
                        .foregroundColor(.green_main)
                }
        }
    }
}

struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckButton(status: .empty)
    }
}
