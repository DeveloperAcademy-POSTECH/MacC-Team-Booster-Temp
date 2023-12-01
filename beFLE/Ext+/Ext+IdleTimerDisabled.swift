//
//  SceneDelegate.swift
//  beFLE
//
//  Created by 정회승 on 12/1/23.
//

import SwiftUI

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }

    //슬립모드 방지
    UIApplication.shared.isIdleTimerDisabled = true
}
