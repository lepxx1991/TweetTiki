//
//  Constants.swift
//  TweetTest
//
//  Created by Tien Phan on 6/6/18.
//  Copyright © 2018 Tien Phan. All rights reserved.
//

import Foundation
import UIKit


let kNumber = 50
enum ValidateError: Error {
    case overCharacter(String)
    case oneLine
    case empty
}

private var tickTimestamp: Date = Date()
func TICK() {
    print("TICK.")
    tickTimestamp = Date()
}

func TOCK() {
    print("TOCK. Elapsed Time: \(Date().timeIntervalSince(tickTimestamp))")
}

