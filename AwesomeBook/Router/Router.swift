//
//  Router.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import UIKit
import SwiftUI

protocol RouterLogic: AnyObject {

  func registerApplication(_ application: UIApplication?)
  func present<Content: View>(_ view: Content, animated: Bool)
  func pushView<Content: View>(_ view: Content, animated: Bool)
  func dismiss(animated: Bool, completion: (() -> Void)?)
  func pop(animated: Bool)
}

final class Router: RouterLogic {

  private weak var application: UIApplication?
  private var window: UIWindow? {
    guard let scene = self.application?.connectedScenes.first,
          let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
          let window = windowSceneDelegate.window else {
      return nil
    }
    return window
  }

  func registerApplication(_ application: UIApplication?) {
    self.application = application
  }
}

// MARK: - present

extension Router {

  func present<Content: View>(_ view: Content, animated: Bool = true) {
    self.present(
      RouterHostingController(rootView: view),
      animated: animated
    )
  }

  func present(_ viewController: UIViewController, animated: Bool = true) {
    DispatchQueue.main.async {
      if let topViewController = self.window?.rootViewController?.presentedTopViewController() {
        topViewController.present(
          viewController,
          animated: animated
        )
      } else {
        self.window?.rootViewController?.present(
          viewController,
          animated: animated
        )
      }
    }
  }

  func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      if let topViewController = self.window?.rootViewController?.presentedTopViewController() {
        topViewController.dismiss(
          animated: animated,
          completion: completion
        )
      } else {
        self.window?.rootViewController?.dismiss(
          animated: animated,
          completion: completion
        )
      }
    }
  }
}

// MARK: - navigation

extension Router {

  func pushView<Content: View>(_ view: Content, animated: Bool = true) {
    let controller = RouterHostingController(rootView: view)
    self.pushViewController(controller, animated: animated)
  }

  func pushViewController(_ viewController: UIViewController, animated: Bool = true) {

    DispatchQueue.main.async {
      self.window?
        .rootViewController?
        .nestedNavigationController()?
        .pushViewController(viewController, animated: animated)
    }
  }

  func pop(animated: Bool = true) {
    DispatchQueue.main.async {
      self.window?
        .rootViewController?
        .nestedNavigationController()?
        .popViewController(animated: animated)
    }
  }
}

// MARK: - search controller

fileprivate extension UIViewController {

  func presentedTopViewController() -> UIViewController? {
    if let presentedViewController = self.presentedViewController?.presentedViewController {
      return presentedViewController.presentedTopViewController()
    } else {
      return self.presentedViewController
    }
  }

  func nestedNavigationController() -> UINavigationController? {
    if let lastPresentedViewController = self.presentedTopViewController(){
      return lastPresentedViewController.nestedNavigationController()
    }

    switch self {
    case let navigationController as UINavigationController:
      return navigationController

    case let tabBarController as UITabBarController:
      return tabBarController.selectedViewController?.nestedNavigationController()

    default:
      for child in children {
        return child.nestedNavigationController()
      }

      return nil
    }
  }
}
