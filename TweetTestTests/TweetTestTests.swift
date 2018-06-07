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
    
    var countTest = 0
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        list.removeAll()
        originalWords.removeAll()
        words.removeAll()
    }
    
    func testExample() {
//        case1()
//        case2()
//        case3()
        case4()
    }
    
    func case1(){
        string = "123 123123123123123123123123123123123123123123123123"
        activeExecute()
        
    }
    
    func case2(){
        string = "111111111111111 22222222222222222 3333333333333333 444444444444444"
        activeExecute()
    }
    
    func case3(){
        string = "111111111111111 22222222222222222 3333333333333333 4444444444444444444444444444444444444444444444444444444444444444444444"
        activeExecute()
    }
    
    func case4(){
        string.removeAll()
        for _ in 0..<70 {
            string.append("Last year, there were around 130,000 Vietnamese studying abroad at all levels, and their top five destinations were Japan, the U.S., Australia, China and the U.K., according to government data. In a report released last June, HSBC said Vietnamese parents place great importance on their child’s education, with spending on education accounting for 47 percent of the total household expenditure. ")
        }
        activeExecute()
       
    }
    
    func activeExecute(){
        if string.count > kNumber && !string.containsWhitespace {
            //Ignore case
            return
        }
        originalWords = string.components(separatedBy: " ")
        words = originalWords
        executeSubTweet(withPage: 1, asumeTotal: 9)
    }
    
    func executeSubTweet(withPage: Int = 1, asumeTotal: Int) {
        if withPage > asumeTotal {
            words = originalWords
            list.removeAll()
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
                list.removeAll()
                return
            }
            count += word.count + 1 // whitespace
            if (count > kNumber) {
                if firstString.count + word.count + 1 > kNumber{
                    AlertVC.alert(nil, message: ElertMessage.over50Chars)
                    list.removeAll()
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
            XCTAssertTrue(string.count <= kNumber, "Text length > 50 chars")
            list.append(string)
            if words.count > 0 {
                executeSubTweet(withPage: withPage + 1, asumeTotal: asumeTotal)
            } else {
                let totalCount = list.count
                list = list.map({$0.replacingOccurrences(of: "/\(asumeTotal)", with: "/\(totalCount)")})
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            self.testExample()
        }
    }
    
}
