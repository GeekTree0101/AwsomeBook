//
//  SearchHeaderView.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/26.
//

import Foundation
import SwiftUI

struct SearchHeaderView: View {

  @Binding
  var text: String

  @Binding
  var isRecommend: Bool

  @Binding
  var resultDescription: String?

  var body: some View {
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
      .padding(.bottom, 12.0)
      if self.isRecommend {
        Text("Recommend books")
          .fontWeight(.bold)
          .foregroundColor(Color(.darkGray))
          .padding(.bottom, 12.0)
          .padding(.leading, 16.0)
          .padding(.trailing, 16.0)
      } else if let desc = self.resultDescription {
        Text(desc)
          .fontWeight(.bold)
          .foregroundColor(Color(.darkGray))
          .padding(.bottom, 12.0)
          .padding(.leading, 16.0)
          .padding(.trailing, 16.0)
      }
    }.background(Color(.systemBackground))
  }
}
