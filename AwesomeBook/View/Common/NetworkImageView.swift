//
//  NetworkImageView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import SwiftUI

import SDWebImageSwiftUI

struct NetworkImageView: View {

  let url: URL?
  let width: CGFloat?
  let height: CGFloat?

  var placehodler: AnyView = AnyView(
    Rectangle()
      .foregroundColor(Color(.systemGray6))
  )
  var background: AnyView = AnyView(
    Rectangle()
      .foregroundColor(Color(.systemGray6))
  )
  var maxWidth: CGFloat?
  var maxHeight: CGFloat?
  var minWidth: CGFloat?
  var minHeight: CGFloat?

  init(url: URL?, all: CGFloat) {
    self.url = url
    self.width = all
    self.height = all
  }

  init(url: URL?,
       width: CGFloat? = nil,
       height: CGFloat? = nil,
       maxWidth: CGFloat? = nil,
       maxHeight: CGFloat? = nil,
       minWidth: CGFloat? = nil,
       minHeight: CGFloat? = nil
  ) {
    self.url = url
    self.width = width
    self.height = height
    self.maxWidth = maxWidth
    self.maxHeight = maxHeight
    self.minWidth = minWidth
    self.minHeight = minHeight
  }

  func placeholder<T>(@ViewBuilder content: () -> T) -> NetworkImageView where T : View {
    var result = self
    result.placehodler = AnyView(content())
    return result
  }

  func background<T>(@ViewBuilder content: () -> T) -> NetworkImageView where T : View {
    var result = self
    result.background = AnyView(content())
    return result
  }

  var body: some View {
    WebImage(url: self.url)
      .resizable()
      .placeholder {
        self.placehodler
      }
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFill()
      .frame(
        minWidth: self.minWidth ?? self.width,
        idealWidth: self.width,
        maxWidth: self.maxWidth ?? self.width,
        minHeight: self.minHeight ?? self.height,
        idealHeight: self.height,
        maxHeight: self.maxHeight ?? self.height,
        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
      )
      .background(
        self.background
      )
  }
}
