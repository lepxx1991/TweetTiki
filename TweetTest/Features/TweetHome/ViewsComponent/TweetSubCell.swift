//
//  TweetSubCell.swift
//  TweetTest
//
//  Created by Tien Phan on 6/6/18.
//  Copyright © 2018 Tien Phan. All rights reserved.
//

import UIKit

class TweetSubCell: UITableViewCell {
    @IBOutlet fileprivate weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ text: String){
        lblTitle.text = "\(text)(\(text.count) chars)"
    }
}
