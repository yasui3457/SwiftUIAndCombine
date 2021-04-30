//
//  ListView.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var vm = ListViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                // List部分
                List(vm.list, id: \.id) { data in
                    Row(data: data)
                }
                // 検索部分
                TextField("検索したい内容を入力してください", text: $vm.searchText)
                    .font(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            // NavigationBarのTitle
            .navigationBarTitle("Stack Overflow List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
