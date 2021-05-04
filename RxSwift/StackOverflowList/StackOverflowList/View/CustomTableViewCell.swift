//
//  CustomTableViewCell.swift
//  StackOverflowList
//
//  Created by riku yasui on 2021/05/01.
//

import UIKit
 
class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var url: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
