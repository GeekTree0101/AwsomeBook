//
//  BookDetailPresenter.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import Combine
import SwiftUI

final class BookDetailPresenter: ObservableObject {

  struct Dependency {
    let bookRepository: BookRepository
  }

  struct Payload {
    let id: String
  }

  @Published
  var contentViewModel: BookDetailView.ViewModel?

  @Published
  var isNotFounded: Bool = false

  private let dependency: Dependency
  private let id: String
  private var cancellables = Set<AnyCancellable>()

  init(dependency: Dependency, payload: Payload) {
    self.dependency = dependency
    self.id = payload.id
  }

  func load() {
    self.dependency.bookRepository.getByID(self.id)
      .sink(
        receiveCompletion: { [weak self] res in
          switch res {
          case .failure:
            self?.isNotFounded = true
          case .finished:
            break
          }
        },
        receiveValue: { [weak self] book in
          self?.contentViewModel = .init(
            title: book.title,
            subtitle: book.subtitle,
            authors: book.authors,
            desc: book.desc,
            image: book.image
          )
          self?.isNotFounded = false
        }
      )
      .store(in: &self.cancellables)
  }

}
