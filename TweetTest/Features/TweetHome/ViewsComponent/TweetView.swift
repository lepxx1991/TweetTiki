//
//  TweetView.swift
//  TweetTest
//
//  Created by Tien Phan on 6/6/18.
//  Copyright © 2018 Tien Phan. All rights reserved.
//

import UIKit

protocol TweetViewDelegate: class {
    func didChangeString(_ text: String)
}

class TweetView: UIView {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: TweetViewDelegate?
    
    var arrSubTweet = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.placeholder = "Type text here"
        textView.delegate = self
        tableView.tableFooterView = UIView()
    }
}

//MARK: - TableView DataSource & Delegate
extension TweetView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubTweet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetSubCell", for: indexPath) as! TweetSubCell
        cell.configCell(arrSubTweet[indexPath.row])
        return cell
    }
}

//MARK: - TextView Delegate
extension TweetView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == UIPasteboard.general.string) {
            let newString = (textView.text as NSString).replacingCharacters(in: range, with: text)
            self.delegate?.didChangeString(newString)
        } else {
            
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.didChangeString(textView.text)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkPlaceholder(textView)
    }
    
    fileprivate func checkPlaceholder(_ textView: UITextView){
        if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = textView.text.count > 0
        }
    }
}

