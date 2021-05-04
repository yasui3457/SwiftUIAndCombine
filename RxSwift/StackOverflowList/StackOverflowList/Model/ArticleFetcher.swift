//
//  ArticleFetcher.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/05/03.
//

import Foundation
import RxSwift

protocol ArticleFetchProtocol {
    func getArticles(tag: String) -> Observable<[StackOverflowData]>
}

final class ArticleFetcher: ArticleFetchProtocol {
    
    private let URLSession: Foundation.URLSession
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func getArticles(tag: String) -> Observable<[StackOverflowData]> {
        guard let url = URL(string: "https://api.stackexchange.com/2.2/questions?page=1%20&pagesize=100%20&order=desc%20&sort=activity%20&tagged=\(tag)%20&site=ja.stackoverflow")
            else {
                print("Couldn't create URL")
                return Observable.just([])
            }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return URLSession.rx.response(request: request)
            .map { pair in
                do {
                    let response = try JSONDecoder().decode(StackOverflowDatas.self, from: pair.data)
                    return response.items
                } catch { throw error}
            }
    }
}
