//
//  RootComponent.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import SwiftUI
import NeedleFoundation

final class RootComponent: BootstrapComponent {

  var rootView: some View {
    return self.searchBuilder.searchView
  }

  var bookSearchService: BookSearchService {
    shared { BookSearchServiceImpl() }
  }

  var bookRepository: BookRepository {
    shared { BookRepositoryImpl() }
  }

  var searchBuilder: SearchBuilder {
    return SearchComponent(parent: self)
  }

  var networking: Networking {
    return shared { CodyFireNetworking() }
  }
}
