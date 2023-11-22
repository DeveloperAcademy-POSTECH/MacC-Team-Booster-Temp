
//
//  Created by 정회승 on 2023/11/23.
//

import Foundation
import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var fileName : String = "BefleLottie"
    var loopMode: LottieLoopMode = .loop
    var animationView = LottieAnimationView()
    
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()
        let animation = LottieAnimation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
    
    class Coordinator: NSObject {
            var parent: LottieView

            init(_ parent: LottieView) {
                self.parent = parent
            }
        }
}
