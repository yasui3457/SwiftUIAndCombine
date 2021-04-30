//
//  ArticleFetcher.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import Foundation
import Combine

class ArticleFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
    func getArticles(tag: String) -> AnyPublisher<StackOverflowDatas, StackOverflowError> {
        guard let url = URL(string: "https://api.stackexchange.com/2.2/questions?page=1%20&pagesize=100%20&order=desc%20&sort=activity%20&tagged=\(tag)%20&site=ja.stackoverflow")
        else {
            let error = StackOverflowError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
  
//    func connect(_ tag: String) {
//        guard let url = URL(string: "https://api.stackexchange.com/2.2/questions?page=1%20&pagesize=100%20&order=desc%20&sort=activity%20&tagged=\(tag)%20&site=ja.stackoverflow")
//        else {
//            print("URL failed.")
//            return
//        }
//        var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                if let data = data {
//                    let list = try! JSONDecoder().decode(StackOverflowDatas.self, from: data)
//                    print(list)
//                }
//            })
//        task.resume()
//    }
}
