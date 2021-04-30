//
//  ListViewModel.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import Foundation
import Combine

final class ListViewModel: ObservableObject  {

    @Published var searchText: String = ""
    @Published private(set) var list: [StackOverflowData] = []
    
    let articleFetcher: ArticleFetcher
    private var disposables = [AnyCancellable]()
    
    init(
        articleFetcher: ArticleFetcher,
        scheduler: DispatchQueue = DispatchQueue(label: "ListViewModel")
    ) {
        self.articleFetcher = articleFetcher
        
        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(0.1), scheduler: scheduler)
            .sink(receiveValue:  fetchArticle(forSearch:) )
            .store(in: &disposables)
    }
    
    func fetchArticle(forSearch search: String) {
        articleFetcher.getArticles(tag: search)
            .print()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.list = []
                    case .finished:
                            break
                    }
                },receiveValue: { [weak self] result in
                    guard let self = self else { return }
                    self.list = result.items
            })
            .store(in: &disposables)
    }
    
}

