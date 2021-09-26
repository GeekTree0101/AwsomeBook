//
//  SearchView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/24.
//

import SwiftUI

struct SearchView: View {

  @EnvironmentObject
  var router: Router
  
  @ObservedObject
  var presenter: SearchPresenter

  @State
  var text: String = ""

  var header: some View {
    VStack(alignment: .leading) {
      Text("AwesomeBook")
        .font(
          Font.system(
            size: 28.0,
            weight: .bold,
            design: .rounded
          )
        )
        .foregroundColor(Color.blue)
        .padding(.leading, 16.0)
        .padding(.bottom, 6.0)
      SearchBar(
        placehodler: "Book...",
        text: $text
      )
      .onQueryChange {
        self.presenter.query = $0
      }
      .padding(.bottom, 12.0)
      if self.presenter.isRecommend {
        Text("Recommend books")
          .fontWeight(.bold)
          .foregroundColor(Color(.darkGray))
          .padding(.bottom, 12.0)
          .padding(.leading, 16.0)
          .padding(.trailing, 16.0)
      } else if let desc = self.presenter.resultDescription {
        Text(desc)
          .fontWeight(.bold)
          .foregroundColor(Color(.darkGray))
          .padding(.bottom, 12.0)
          .padding(.leading, 16.0)
          .padding(.trailing, 16.0)
      }
    }.background(Color(.systemBackground))
  }

  var body: some View {
    NavigationView {
      ZStack {
        self.list
        SceneIndicatorView(status: self.$presenter.loadingStatus)
      }
      .navigationBarHidden(true)
    }
  }

  var list: some View {
    ScrollView {
      LazyVStack(
        alignment: .leading,
        pinnedViews: .sectionHeaders,
        content: {
          Section(header: header) {
            ForEach(
              self.presenter.items,
              id: \.id
            ) { viewModel in
              SearchResultView(
                viewModel: viewModel
              ).onSelect { () in
                self.router.pushView(
                  self.presenter.bookDetailView(
                    viewModel.id
                  )
                )
              }
            }
          }
          PageIndicatorView(
            status: self.$presenter.loadingStatus,
            hasNextPage: self.$presenter.hasNextPage
          )
          .onFetch {
            self.presenter.next()
          }
        }
      )
    }.padding(.top, 16.0)
  }
}

struct SearchView_Previews: PreviewProvider {
  
  static var previews: some View {
    SearchView(
      presenter: SearchPresenter(
        dependency: SearchPresenter.Dependency(
          bookRepository: BookRepositoryImpl(),
          bookSearchService: BookSearchServiceImpl(),
          bookDetailBuilder: nil
        )
      )
    )
  }
}
