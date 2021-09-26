//
//  AwesomeBookApp.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation
import SwiftUI

import CodyFire
import NeedleFoundation

@main
struct AwesomeBookApp: App {

  @UIApplicationDelegateAdaptor(AwesomeBookAppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      self.appDelegate.rootComponent.rootView
        .environmentObject(self.appDelegate.router)
    }
  }

}
