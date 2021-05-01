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
    
    var list: [StackOverflowData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        self.getArticles(tag: searchTextField.text!)
        return true
    }
}

// MARK: Private Method
extension ViewController {
    private func getArticles(tag: String) {
        guard let url = URL(string: "https://api.stackexchange.com/2.2/questions?page=1%20&pagesize=100%20&order=desc%20&sort=activity%20&tagged=\(tag)%20&site=ja.stackoverflow") else {
            print("URL failed.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                let list = try! JSONDecoder().decode(StackOverflowDatas.self, from: data)
                print(list)
                self.list = list.items
            }
        })
        task.resume()
    }
}

