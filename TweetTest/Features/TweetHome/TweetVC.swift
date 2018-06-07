//
//  TweetVC.swift
//  TweetTest
//
//  Created by Tien Phan on 6/6/18.
//  Copyright © 2018 Tien Phan. All rights reserved.
//

import UIKit


class TweetVC: UIViewController {
    @IBOutlet fileprivate weak var _view: TweetView!
    
    var arrSubTweet = [String]()
    
    var words = [String]()
    var originalWords = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        _view.delegate = self
        setupNavigationBar()
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: Setup Viewscomponent
    
    fileprivate func setupNavigationBar(){
        self.title = "Tweet"
        let rightItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postAction))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    //MARK: Private method
    @objc fileprivate func postAction(_ sender: UIBarButtonItem){
        self.arrSubTweet.removeAll()
        self._view.removeAllSubTweet()
        AlertVC.alert(nil, message: "Posted")
    }
    
    @IBAction fileprivate func makeAction(_ sender: UIButton) {
        self._view.endEditing(true)
        activeExecuteSubTweet(self._view.textView.text)
    }
    
    fileprivate func activeExecuteSubTweet(_ text: String){
        self.arrSubTweet.removeAll()
        
        ///Validate string
        do {
            try _view.textView.text.validateString()
        } catch let ValidateError.overCharacter(message) {
            AlertVC.alert(nil, message: message)
            return
        } catch ValidateError.oneLine {
            self.arrSubTweet.append(text)
            self._view.arrSubTweet = self.arrSubTweet
            return
        } catch ValidateError.empty {
            self._view.arrSubTweet = self.arrSubTweet
            return
        } catch {
            AlertVC.alert(nil, message: "Unknow error")
            return
        }
        
        originalWords = text.components(separatedBy: " ")
        words = originalWords
        executeSubTweet(withPage: 1, asumeTotal: 9)
    }
    
    //MARK: Helper
    
    func executeSubTweet(withPage: Int = 1, asumeTotal: Int) {
        if withPage > asumeTotal {
            words = originalWords
            arrSubTweet.removeAll()
            let asumeTotalInt = Int("\(asumeTotal)9") ?? 9
            executeSubTweet(withPage: 1, asumeTotal: asumeTotalInt)
            return
        }
        var collectedWords = [String]()
        
        var count = 0
        let firstString = "\(withPage)/\(asumeTotal)"
        count = firstString.count
        
        collectedWords.append(firstString)
        
        var deleteWord = [Int]()
        for i in 0..<words.count {
            let word = words[i]
            if word.count > kNumber {
                AlertVC.alert(nil, message: ElertMessage.over50Chars)
                arrSubTweet.removeAll()
                self._view.removeAllSubTweet()
                return
            }
            count += word.count + 1 // whitespace
            if (count > kNumber) {
                if firstString.count + word.count + 1 > kNumber{
                    AlertVC.alert(nil, message: ElertMessage.over50Chars)
                    arrSubTweet.removeAll()
                    self._view.removeAllSubTweet()
                    return
                }
                break
            } else {
                deleteWord.append(i)
                collectedWords.append(word)
            }
        }
        deleteWord.reverse()
        for index in deleteWord {
            words.remove(at: index)
        }
        
        if !collectedWords.isEmpty {
            let string = collectedWords.map { String($0) }.joined(separator: " ")
            arrSubTweet.append(string)
            if words.count > 0 {
                executeSubTweet(withPage: withPage + 1, asumeTotal: asumeTotal)
            } else {
                let totalCount = arrSubTweet.count
                arrSubTweet = arrSubTweet.map({$0.replacingOccurrences(of: "/\(asumeTotal)", with: "/\(totalCount)")})
                self._view.arrSubTweet = arrSubTweet
            }
        }
    }
    
    fileprivate func insertFirstTextSubTweet( countChar: inout Int,  expectText: inout String, word: String, wordsCount: Int){
        let firstText = "\(arrSubTweet.count + 1)/\(wordsCount) "
        countChar += (firstText.count + word.count)
        expectText += "\(firstText)\(word)"
    }
}

//MARK: - TweetViewDelegate
extension TweetVC: TweetViewDelegate {
    func didChangeString(_ text: String) {
//        activeExecuteSubTweet(text)
    }
}
