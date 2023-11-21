//
//  RoundedShape.swift
//  Mac_Health
//
//  Created by 정회승 on 11/18/23.
//

import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 8, height: 8))
    
        return Path(path.cgPath)
    }
}

