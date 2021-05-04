//
//  ListViewModel.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/05/01.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol ListViewModelInput {
    var searchTrigger: AnyObserver<String?> { get }
}

protocol ListViewModelOutput {
    var items: Observable<[StackOverflowData]> { get }
}

protocol ListViewModelType {
    var inputs: ListViewModelInput { get }
    var outputs: ListViewModelOutput { get }
}

final class ListViewModel: ListViewModelType, ListViewModelInput, ListViewModelOutput {
    var inputs: ListViewModelInput { return self }
    var outputs: ListViewModelOutput { return self }

    // MARK: Inputs
    let searchTrigger: AnyObserver<String?>

    // MARK: Outputs
    let items: Observable<[StackOverflowData]>

    private let disposeBag = DisposeBag()
    
    
    init(debounceScheduler: SchedulerType = ConcurrentMainScheduler.instance) {
        // Inputの初期化
        let _searchTrigger = PublishRelay<String?>()
        self.searchTrigger = AnyObserver<String?>() { event in
            guard let text = event.element else {
                return
            }
            _searchTrigger.accept(text)
        }
        //Outputの初期化
        let _items = BehaviorRelay<[StackOverflowData]>(value: [])
        self.items = _items.asObservable()

        let searchWithText = _searchTrigger
            .debounce(RxTimeInterval.milliseconds(500), scheduler: debounceScheduler)
            .flatMap{text -> Observable<String> in
                guard let text = text else {
                    return .empty()
                }
                print(text)
                return .just(text)
            }
            .share()
        do {
            let searchResult = searchWithText
                .flatMap { text -> Observable<Event<[StackOverflowData]>> in
                    ArticleFetcher(URLSession: .shared)
                        .getArticles(tag: text)
                        .materialize()
                }
                .share()
            
            searchResult
                .flatMap { $0.element.map(Observable.just) ?? .empty() }
                .bind(to: _items)
                .disposed(by: disposeBag)
        }
        
    }
    
}
