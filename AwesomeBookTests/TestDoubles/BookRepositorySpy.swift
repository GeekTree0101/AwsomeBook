//
//  BookRepositorySpy.swift
//  AwesomeBookTests
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import Combine

@testable import AwesomeBook

final class BookRepositorySpy: BookRepository {

  var getByIDBook: Book?

  func getByID(_ id: String) -> Future<Book, Error> {
    return Future<Book, Error> { seal in
      if let book = self.getByIDBook {
        seal(.success(book))
      } else {
        seal(.failure(NSError()))
      }
    }
  }

  var saveCalled: Int = 0

  func save(_ book: Book, update: (inout Book) -> Void) {
    self.saveCalled += 1
  }

  var deleteByIDCalled: Int = 0

  func deleteByID(_ id: String) {
    self.deleteByIDCalled += 1
  }
}
