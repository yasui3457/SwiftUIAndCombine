//
//  ListViewController.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/04/30.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    typealias Input = ListViewModelInput
    typealias Output = ListViewModelOutput
    private var input: Input!
    private var output: Output!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                                   forCellReuseIdentifier: "cell")
        tableView.delegate = self
        
        // ViewModelとのバインディング
        prepareRx()
    }
    
    private func prepareRx() {
        let viewModel = ListViewModel()
        self.input = viewModel
        self.output = viewModel
        
        searchTextField.rx.text
            .bind(to: input.searchTrigger)
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) {_,result,cell in
                guard let cell = cell as? CustomTableViewCell else {
                    return
                }
                cell.title.text = result.title
                cell.url.text = result.link
            }
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
