//
//  Future+Extension.swift
//  AwesomeBookTests
//
//  Created by Geektree0101 on 2021/09/25.
//

import Foundation
import Combine

extension Future {

  static func failure(_ error: Failure) -> Future {
    return Future { seal in
      seal(.failure(error))
    }
  }

  static func success(_ t: Output) -> Future {
    return Future { seal in
      seal(.success(t))
    }
  }
}
