//
//  Row.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import SwiftUI

struct Row: View {
    var data: StackOverflowData
    
    var body: some View {
        VStack {
            HStack {
                Text(data.title)
                    .bold()
                Spacer()
            }
            HStack {
                Text(data.url)
                Spacer()
            }
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Row(data: stackOverflowDatas[0])
                .previewLayout(.fixed(width: 300, height: 70))
            Row(data: stackOverflowDatas[1])
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
