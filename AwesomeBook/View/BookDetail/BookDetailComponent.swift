//
//  BookDetailComponent.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import NeedleFoundation

struct BookDetailPayload {
  let id: String
}

protocol BookDetailDependency: Dependency {

  var bookRepository: BookRepository { get }
}

protocol BookDetailBuilder {

  func bookDetailView(_ payload: BookDetailPayload) -> BookDetailView
}

final class BookDetailComponent: Component<BookDetailDependency>, BookDetailBuilder {

  func bookDetailView(_ payload: BookDetailPayload) -> BookDetailView {
    return BookDetailView(
      presenter: BookDetailPresenter(
        dependency: BookDetailPresenter.Dependency(
          bookRepository: self.bookRepository
        ),
        payload: BookDetailPresenter.Payload(
          id: payload.id
        )
      )
    )
  }
}
