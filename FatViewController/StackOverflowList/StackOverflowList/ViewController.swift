//
//  ViewController.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    let list: [StackOverflowData] = [
                                        StackOverflowData(question_id: 1, title: "title1", link: "https://hogehoge.com/url1"),
                                        StackOverflowData(question_id: 2, title: "title2", link: "https://hogehoge.com/url2"),
                                        StackOverflowData(question_id: 3, title: "title3", link: "https://hogehoge.com/url3"),
                                        StackOverflowData(question_id: 4, title: "title4", link: "https://hogehoge.com/url4"),
                                        StackOverflowData(question_id: 5, title: "title5", link: "https://hogehoge.com/url5"),
                                        StackOverflowData(question_id: 6, title: "title6", link: "https://hogehoge.com/url6"),
                                        StackOverflowData(question_id: 7, title: "title7", link: "https://hogehoge.com/url7"),
                                        StackOverflowData(question_id: 8, title: "title8", link: "https://hogehoge.com/url8"),
                                        StackOverflowData(question_id: 9, title: "title9", link: "https://hogehoge.com/url9"),
                                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegateの設定
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        
        // TableViewの準備
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),forCellReuseIdentifier:"cell")
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ table: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.title?.text = list[indexPath.row].title
        cell.url?.text = list[indexPath.row].link
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

