//
//  BookAPI.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation

import CodyFire

enum BookAPI {

  enum GetBook {

    struct Request {

      let id: String

      init(id: String) {
        self.id = id
      }
    }

    struct Response: Codable {

      enum CodingKeys: String, CodingKey {
        case id = "isbn13"
        case title
        case subtitle
        case authors
        case publisher
        case language
        case pages
        case year
        case rating
        case desc
        case price
        case image
      }

      var id: String
      var title: String?
      var subtitle: String?
      var authors: String?
      var publisher: String?
      var language: String?
      var pages: String?
      var year: String?
      var rating: String?
      var desc: String?
      var price: String?
      var image: URL?
    }

    static func call(_ request: Request) -> APIRequest<Response> {
      return APIRequest(
        "books/\(request.id)",
        payload: nil
      )
      .method(.get)
      .addCustomError(.notFound, "not found")
    }
  }
}
