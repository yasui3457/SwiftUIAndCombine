//
//  ListView.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView{
            List(stackOverflowDatas, id: \.id) { data in
                Row(data: data)
            }
            .navigationBarTitle("Stack Overflow List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
