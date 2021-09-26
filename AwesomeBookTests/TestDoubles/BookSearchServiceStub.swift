//
//  BookSearchServiceStub.swift
//  AwesomeBookTests
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import Combine

@testable import AwesomeBook

final class BookSearchServiceStub: BookSearchService {

  var searchBooksStub: Future<SearchAPI.GetBooks.Response, Error> = .failure(NSError())

  func searchBooks(_ request: SearchAPI.GetBooks.Request) -> Future<SearchAPI.GetBooks.Response, Error> {
    return self.searchBooksStub
  }
}
