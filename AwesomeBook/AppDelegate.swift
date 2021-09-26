//
//  AppDelegate.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation
import UIKit
import SwiftUI

import CodyFire

final class AwesomeBookAppDelegate: NSObject, UIApplicationDelegate {
  
  var rootComponent: RootComponent!
  var window: UIWindow?
  var router = Router()
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    registerProviderFactories()
    self.rootComponent = RootComponent()
    self.rootComponent.networking.configure()
    self.router.application = application
    return true
  }
}
