//
//  SearchResultView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/24.
//

import SwiftUI

import SDWebImageSwiftUI

struct SearchResultView: View {

  struct ViewModel: Hashable {
    let id: String
    let imageURL: URL?
    let title: String
    let subtitle: String
    let price: String
  }

  var viewModel: ViewModel

  var selectHandler: (() -> Void)?

  var body: some View {
    Button(action: {
      self.selectHandler?()
    }) {
      self.imageWithContentView
        .padding(.top, 8.0)
        .padding(.leading, 8.0)
        .padding(.trailing, 8.0)
    }
    .buttonStyle(PlainButtonStyle())
  }

  var imageWithContentView: some View {
    VStack(alignment: .leading, spacing: 4.0) {
      HStack(alignment: .top, spacing: 16.0) {
        self.imageView
        self.contentView
          .layoutPriority(1)
      }
      Divider()
    }
  }

  var imageView: some View {
    NetworkImageView(
      url: self.viewModel.imageURL,
      all: 80.0
    )
  }

  var contentView: some View {
    VStack(alignment: .leading) {
      Text(self.viewModel.title)
        .font(.system(size: 16.0))
        .lineLimit(1)
        .padding(.bottom, 2.0)
      if !self.viewModel.subtitle.isEmpty {
        Text(self.viewModel.subtitle)
          .font(.system(size: 12.0))
          .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
          .padding(.bottom, 4.0)
      }
      Text(self.viewModel.price)
        .font(.system(size: 16.0))
        .bold()
      Spacer()
    }
  }

  func onSelect(_ handler: @escaping () -> Void) -> Self {
    var result = self
    result.selectHandler = handler
    return result
  }
}

struct SearchResultView_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultView(
      viewModel: SearchResultView.ViewModel(
        id: "ddd",
        imageURL: URL(string: "https://itbook.store/img/books/9781782163688.png"),
        title: "iferay Portal Performance Best Practices",
        subtitle: "A practical tutorial to learn the best practices for building high performing Liferay-based solutions",
        price: "$16.99"
      )
    )
  }
}
