//
//  SearchPresenter.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import Combine
import SwiftUI

final class SearchPresenter: ObservableObject {

  struct Dependency {
    let bookRepository: BookRepository
    let bookSearchService: BookSearchService
    let bookDetailBuilder: BookDetailBuilder!
    let router: RouterLogic
  }

  @Published
  var items: [SearchResultView.ViewModel] = []

  @Published
  var errorMessage: String?

  @Published
  var query: String = ""

  @Published
  var loadingStatus: IndicatorStatus = .end

  @Published
  var hasNextPage: Bool = false

  @Published
  var isRecommend: Bool = true

  @Published
  var resultDescription: String?

  private var currentPage: Int = 1
  private var currentQuery: String?
  private let dependency: Dependency
  private var cancellables = Set<AnyCancellable>()

  init(dependency: Dependency) {
    self.dependency = dependency
    self.sinkQuery()
  }

  private func sinkQuery() {
    self.$query
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .sink(receiveValue: { [weak self] query in
        guard let self = self else { return }

        if query.isEmpty {
          self.isRecommend = true
          self.reload(query: "swift")
          return
        }

        self.isRecommend = false
        self.reload(query: query)
      })
      .store(in: &self.cancellables)
  }

  private func reload(query: String) {
    self.currentQuery = query

    let request = SearchAPI.GetBooks.Request(
      query: query,
      queryString: SearchAPI.GetBooks.Request.QueryString(
        page: 1
      )
    )

    self.loadingStatus = .reload

    self.dependency.bookSearchService.searchBooks(request)
      .sink(
        receiveCompletion: { [weak self] res in
          switch res {
          case let .failure(error):
            self?.errorMessage = error.localizedDescription
            self?.resultDescription = nil
          case .finished:
            self?.errorMessage = nil
          }
          self?.loadingStatus = .end
        },
        receiveValue: { [weak self] res in
          guard let self = self else { return }
          self.errorMessage = nil
          self.currentPage = Int(res.page ?? "") ?? 1
          self.hasNextPage = !res.books.isEmpty && !self.isRecommend
          self.items = res.books.map({
            SearchResultView.ViewModel(
              id: $0.id,
              imageURL: $0.image,
              title: $0.title ?? "",
              subtitle: $0.subtitle ?? "",
              price: $0.price ?? "free"
            )
          })
          self.resultDescription = "About \(res.total ?? "0") results"
          self.loadingStatus = .end
        }
      )
      .store(in: &self.cancellables)
  }

  func next() {
    let request = SearchAPI.GetBooks.Request(
      query: self.currentQuery ?? "",
      queryString: SearchAPI.GetBooks.Request.QueryString(
        page: self.currentPage + 1
      )
    )

    self.loadingStatus = .next

    self.dependency.bookSearchService.searchBooks(request)
      .sink(
        receiveCompletion: { [weak self] res in
          switch res {
          case let .failure(error):
            self?.errorMessage = error.localizedDescription
          case .finished:
            self?.errorMessage = nil
          }
          self?.loadingStatus = .end
        },
        receiveValue: { [weak self] res in
          guard let self = self else { return }
          self.errorMessage = nil
          self.currentPage = Int(res.page ?? "") ?? (self.currentPage + 1)
          self.hasNextPage = !res.books.isEmpty && !self.isRecommend
          self.items += res.books.map({
            SearchResultView.ViewModel(
              id: $0.id,
              imageURL: $0.image,
              title: $0.title ?? "",
              subtitle: $0.subtitle ?? "",
              price: $0.price ?? "free"
            )
          })
          self.loadingStatus = .end
        }
      )
      .store(in: &self.cancellables)
  }

  func pushBookDetailView(_ id: String) {
    
    self.dependency.router.pushView(
      self.dependency.bookDetailBuilder.bookDetailView(
        BookDetailPayload(id: id
        )
      ),
      animated: true
    )
  }
}
