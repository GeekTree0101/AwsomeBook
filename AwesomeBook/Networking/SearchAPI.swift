//
//  SearchAPI.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation

import CodyFire

enum SearchAPI {

  // MARK: - https://api.itbook.store/1.0/search/{keyword}

  enum GetBooks {

    struct Request {

      struct QueryString: Codable {

        let page: Int

        init(page: Int) {
          self.page = page
        }
      }

      let query: String
      let queryString: QueryString

      init(query: String, queryString: QueryString) {
        self.query = query
        self.queryString = queryString
      }
    }

    struct Response: Codable {

      struct Book: Codable {

        enum CodingKeys: String, CodingKey {
          case id = "isbn13"
          case title
          case subtitle
          case price
          case image
        }

        let id: String
        let title: String?
        let subtitle: String?
        let price: String?
        let image: URL?
      }

      enum CodingKeys: String, CodingKey {
        case total
        case page
        case books
      }

      var total: String?
      var page: String?
      var books: [Book]
    }

    static func call(_ request: Request) -> APIRequest<Response> {
      return APIRequest(
        "search/\(request.query)",
        payload: nil
      )
      .query(request.queryString)
      .method(.get)
      .addCustomError(.notFound, "not found")
    }
  }

}
