//
//  SearchComponent.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation

import NeedleFoundation

protocol SearchDependency: Dependency {

  var bookSearchService: BookSearchService { get }
  var bookRepository: BookRepository { get }
  var router: RouterLogic { get }
}

protocol SearchBuilder {
  var searchView: SearchView { get }
}

final class SearchComponent: Component<SearchDependency>, SearchBuilder {

  var searchView: SearchView {
    return SearchView(
      presenter: SearchPresenter(
        dependency: SearchPresenter.Dependency(
          bookRepository: self.bookRepository,
          bookSearchService: self.bookSearchService,
          bookDetailBuilder: self.bookDetailBuilder,
          router: self.router
        )
      )
    )
  }

  var bookDetailBuilder: BookDetailBuilder {
    return BookDetailComponent(parent: self)
  }
}
