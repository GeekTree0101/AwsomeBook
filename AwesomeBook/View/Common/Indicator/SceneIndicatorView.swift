//
//  SceneIndicatorView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import SwiftUI

struct SceneIndicatorView: View {

  @Binding
  var status: IndicatorStatus

  var body: some View {
    VStack {
      Spacer()
      if self.status == .reload {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
          .scaleEffect(1.5)
      }
      Spacer()
    }
  }
}
