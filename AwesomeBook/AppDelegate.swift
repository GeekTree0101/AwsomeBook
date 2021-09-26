//
//  AppDelegate.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import UIKit
import SwiftUI

import NeedleFoundation
import CodyFire

final class AwesomeBookAppDelegate: NSObject, UIApplicationDelegate {
  
  let rootComponent: RootComponent
  let router = Router()

  override init() {
    registerProviderFactories()
    self.rootComponent = RootComponent()
    super.init()
  }
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    self.rootComponent.networking.configure()
    self.router.application = application
    return true
  }
}
