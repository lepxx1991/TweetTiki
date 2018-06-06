//
//  TweetTestTests.swift
//  TweetTestTests
//
//  Created by Tien Phan on 6/6/18.
//  Copyright © 2018 Tien Phan. All rights reserved.
//

import XCTest
@testable import TweetTest

class TweetTestTests: XCTestCase {
    
    var string = "Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to show the dialog at a more appropriate time move this registration accordingly. Register for remote notifications. This shows a permission dialog on first run to "
    
    var words = [String]()
    var originalWords = [String]()
    var list = [String]()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        if string.count > kNumber && !string.containsWhitespace {
            //Ignore case
            return
        }
        originalWords = string.components(separatedBy: " ")
        words = originalWords
        executeSubTweet(withPage: 1, asumeTotal: 1)
    }
    
    func executeSubTweet(withPage: Int = 1, asumeTotal: Int) {
        if withPage > asumeTotal {
            words = originalWords
            list.removeAll()
            executeSubTweet(withPage: 1, asumeTotal: asumeTotal * 10)
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
            count += word.count + 1 // whitespace
            if (count > kNumber) {
                deleteWord.append(i)
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
            print(string.count)
            list.append(string)
            if words.count > 0 {
                executeSubTweet(withPage: withPage + 1, asumeTotal: asumeTotal)
            } else {
                let totalCount = list.count
                list = list.map({$0.replacingOccurrences(of: "/\(asumeTotal)", with: "/\(totalCount)")})
                print(list)
                print("Done")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
