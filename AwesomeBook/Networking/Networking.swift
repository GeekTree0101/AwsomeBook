//
//  Networking.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import CodyFire

protocol Networking {

  func configure()
}

struct CodyFireNetworking: Networking {

  private let codyFire: CodyFire = CodyFire.shared

  func configure() {
    let dev = CodyFireEnvironment(baseURL: "https://api.itbook.store/1.0")
    let testFlight = CodyFireEnvironment(baseURL: "https://api.itbook.store/1.0")
    let appStore = CodyFireEnvironment(baseURL: "https://api.itbook.store/1.0")
    self.codyFire.configureEnvironments(dev: dev, testFlight: testFlight, appStore: appStore)
    self.codyFire.logLevel = .debug
  }
}
