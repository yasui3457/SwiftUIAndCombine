//
//  StackOverflowDatas.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import Foundation

struct StackOverflowDatas: Hashable, Codable {
    var items: [StackOverflowData]
}

struct StackOverflowData: Hashable, Codable {
    var question_id: Int
    var title: String
    var link: String
}
