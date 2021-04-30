//
//  StackOverflowError.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import Foundation

enum StackOverflowError: Error {
    case parsing(description: String)
    case network(description: String)
}
