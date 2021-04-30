//
//  ListViewModel.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import Foundation
import Combine

final class ListViewModel: ObservableObject  {
    // MARK: Input
    @Published var searchText: String = ""
    
    // MARK: Output
    @Published private(set) var list: [StackOverflowData] = stackOverflowDatas
    
    // MARK: Action
}

