//
//  PageIndicatorView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import SwiftUI

struct PageIndicatorView: View {

  var fetchHandler: (() -> Void)?

  @Binding
  var status: IndicatorStatus

  @Binding
  var hasNextPage: Bool

  var body: some View {
    HStack {
      Spacer()
      if self.hasNextPage {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
          .scaleEffect(1.5)
      }
      Spacer()
    }
    .frame(height: self.hasNextPage ? 120.0 : nil)
    .onAppear(perform: {
      guard self.status == .end && self.hasNextPage else { return }
      self.fetchHandler?()
    })
  }

  func onFetch(_ fetchHandler: @escaping () -> Void) -> Self {
    var result = self
    result.fetchHandler = fetchHandler
    return result
  }
}
