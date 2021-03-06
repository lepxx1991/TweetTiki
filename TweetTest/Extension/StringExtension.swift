//
//  StringExtension.swift
//  TweetTest
//
//  Created by Tien Phan on 6/6/18.
//  Copyright © 2018 Tien Phan. All rights reserved.
//

import Foundation

extension String {
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var condensedWhitespace: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func validateString() throws {
        if self.count > kNumber && !self.containsWhitespace {
            throw ValidateError.overCharacter(ElertMessage.over50Chars)
        } else if self.count <= kNumber && !self.isEmpty{
            throw ValidateError.oneLine
        } else if self.isEmpty{
            throw ValidateError.empty
        }
    }
}
