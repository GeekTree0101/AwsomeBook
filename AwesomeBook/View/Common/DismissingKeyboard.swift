//
//  DismissingKeyboard.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import SwiftUI

struct DismissingKeyboard: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onTapGesture {
        let keyWindow = UIApplication.shared.connectedScenes
          .filter({$0.activationState == .foregroundActive})
          .map({$0 as? UIWindowScene})
          .compactMap({$0})
          .first?.windows
          .filter({$0.isKeyWindow}).first
        keyWindow?.endEditing(true)
      }
  }
}
