//
//  SceneDelegate.swift
//  beFLE
//
//  Created by 정회승 on 12/1/23.
//

import SwiftUI

extension UISceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
}
