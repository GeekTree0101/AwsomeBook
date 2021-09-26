//
//  BookDetailView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import SwiftUI

struct BookDetailView: View {

  @Environment(\.colorScheme) var colorScheme

  struct ViewModel {
    let title: String?
    let subtitle: String?
    let authors: String?
    let desc: String?
    let image: URL?
  }

  @ObservedObject
  var presenter: BookDetailPresenter

  var body: some View {
    ScrollView {
      if self.presenter.isNotFounded {
        self.notFoundView
      } else {
        self.contentView
      }
    }
    .onAppear {
      self.presenter.load()
    }
  }

  var contentView: some View {
    VStack(spacing: 24.0) {
      NetworkImageView(
        url: self.presenter.contentViewModel?.image,
        all: 200
      ).background {
        Rectangle()
          .foregroundColor(Color(.systemBackground))
      }
      self.infoView
        .padding(.leading, 16.0)
        .padding(.trailing, 16.0)
      Spacer()
    }
  }

  var infoView: some View {
    VStack(spacing: 8.0) {
      if let title = self.presenter.contentViewModel?.title,
         title.isEmpty == false {
        Text(title)
          .font(Font.system(size: 24.0, weight: .bold))
          .foregroundColor(Color(self.colorScheme == .dark ? .white : .black))
      }
      if let subtitle = self.presenter.contentViewModel?.subtitle,
         subtitle.isEmpty == false {
        Text(subtitle)
          .font(Font.system(size: 14.0))
          .foregroundColor(Color(.darkGray))
      }
      Text(self.presenter.contentViewModel?.authors ?? "")
        .font(Font.system(size: 12.0, weight: .bold))
        .foregroundColor(Color(.darkGray))
      Text(self.presenter.contentViewModel?.desc ?? "")
        .font(Font.system(size: 16.0, weight: .regular))
        .foregroundColor(Color(self.colorScheme == .dark ? .white : .black))
    }
  }

  var notFoundView: some View {
    VStack {
      Spacer()
      Text("Not founded")
        .font(Font.system(size: 24.0, weight: .bold))
        .foregroundColor(Color(.darkGray))
        .padding(.leading, 16.0)
        .padding(.trailing, 16.0)
      Spacer()
    }
  }
}

struct BookDetailView_Previews: PreviewProvider {
  static var previews: some View {
    BookDetailView(
      presenter: BookDetailPresenter(
        dependency: BookDetailPresenter.Dependency(
          bookRepository: BookRepositoryImpl()),
        payload: BookDetailPresenter.Payload(
          id: "9780983066989"
        )
      )
    )
  }
}
