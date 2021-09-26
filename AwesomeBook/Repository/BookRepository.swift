//
//  BookRepository.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import Combine

protocol BookRepository {

  func getByID(_ id: String) -> Future<Book, Error>
  func save(_ book: Book, update: (inout Book) -> Void)
  func deleteByID(_ id: String)
}

final class BookRepositoryImpl: BookRepository {

  private var books: [Book] = []

  func getByID(_ id: String) -> Future<Book, Error> {
    return Future<Book, Error> { seal in

      if let book = self.books.first(where: { $0.id == id }) {
        seal(.success(book))
        return
      }

      BookAPI.GetBook
        .call(BookAPI.GetBook.Request(id: id))
        .onSuccess {
          let book = Book(
            id: $0.id,
            title: $0.title,
            subtitle: $0.subtitle,
            authors: $0.authors,
            publisher: $0.publisher,
            language: $0.language,
            pages: $0.pages,
            year: $0.year,
            rating: $0.rating,
            desc: $0.desc,
            price: $0.price,
            image: $0.image
          )

          self.save(book, update: {
            $0 = book
          })

          seal(.success(book))
        }
        .onError { error in
          seal(.failure(error))
        }
    }
  }

  func save(_ book: Book, update: (inout Book) -> Void) {
    guard let index = self.books.firstIndex(where: { $0.id == book.id }) else {
      self.books.append(book)
      return
    }

    update(&self.books[index])
  }

  func deleteByID(_ id: String) {
    self.books.removeAll(where: { $0.id == id })
  }
}
