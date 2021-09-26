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
          Section(
            header: SearchHeaderView(
              text: self.$presenter.query,
              isRecommend: self.$presenter.isRecommend,
              resultDescription: self.$presenter.resultDescription
            )
          ) {
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
