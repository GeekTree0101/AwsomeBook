//
//  SearchBar.swift
//  AwesomeBook
//
//  Created by Geektree0101 on 2021/09/24.
//

import SwiftUI

struct SearchBar: View {

  let placehodler: String
  var queryChangeHandler: ((String) -> Void)?

  @Binding
  var text: String

  func onQueryChange(_ queryChangeHandler: @escaping (String) -> Void) -> Self {
    var result = self
    result.queryChangeHandler = queryChangeHandler
    return result
  }

  var body: some View {
    HStack {
      TextField(self.placehodler, text: $text)
        .padding(.horizontal, 14.0)
        .padding(.vertical, 12.0)
        .background(Color(.systemGray6))
        .cornerRadius(8.0)
        .padding(.horizontal, 12.0)
        .onChange(of: self.text, perform: { value in
          self.queryChangeHandler?(value)
        })
    }
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(placehodler: "test", text: .constant(""))
  }
}
