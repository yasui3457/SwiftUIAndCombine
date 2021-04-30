//
//  Parsing.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import Foundation
import Combine

func decode<StackOverflowDatas: Decodable>(_ data: Data) -> AnyPublisher<StackOverflowDatas, StackOverflowError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: StackOverflowDatas.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
