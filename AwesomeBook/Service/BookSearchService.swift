//
//  BookSearchService.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import Combine

protocol BookSearchService {

  func searchBooks(_ request: SearchAPI.GetBooks.Request) -> Future<SearchAPI.GetBooks.Response, Error>
}

final class BookSearchServiceImpl: BookSearchService {

  func searchBooks(_ request: SearchAPI.GetBooks.Request) -> Future<SearchAPI.GetBooks.Response, Error> {

    return Future<SearchAPI.GetBooks.Response, Error> { seal in

      SearchAPI.GetBooks.call(request)
        .onSuccess {
          seal(.success($0))
        }
        .onError {
          seal(.failure($0))
        }
    }
  }

}
