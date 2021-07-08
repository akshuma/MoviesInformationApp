//
//  String+Extension.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import Foundation

extension String {
    
    //Convert TimeStemp to string according to dateFormat
    static func convertDateToStringUsingTimeStamp(_ timeStamp: String, dateFormat: String) -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = dateFormat
        let date = formatterDate.date(from: timeStamp)
        let myString = formatterDate.string(from: date ?? Date())
        let yourDate = formatterDate.date(from: myString)
        formatterDate.dateFormat = "EEEE, d MMMM"
        let myStringafd = formatterDate.string(from: yourDate!)
        return myStringafd
        
    }
    
    // String Blank 
    static var blank: String {
        return ""
    }
}



extension String {
    
    fileprivate var skipTable: [Character: Int] {
        var skipTable: [Character: Int] = [:]
        for (i, c) in enumerated() {
            skipTable[c] = count - i - 1
        }
        return skipTable
    }
    
    fileprivate func match(from currentIndex: Index, with pattern: String) -> Index? {
        if currentIndex < startIndex { return nil }
        if currentIndex >= endIndex { return nil }
        
        if self[currentIndex] != pattern.last { return nil }
        
        if pattern.count == 1 && self[currentIndex] == pattern.last { return currentIndex }
        return match(from: index(before: currentIndex), with: "\(pattern.dropLast())")
    }
    
    func index(of pattern: String) -> Index? {
        let patternLength = pattern.count
        guard patternLength > 0, patternLength <= count else { return nil }
        let skipTable = pattern.skipTable
        let lastChar = pattern.last!
        
        var i = index(startIndex, offsetBy: patternLength - 1)
        
        while i < endIndex {
            let c = self[i]
            
            if c == lastChar {
                if let k = match(from: i, with: pattern) { return k }
                i = index(after: i)
            } else {
                i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
            }
        }
        return nil
    }
}

extension String {
    func searchMovie(_ query: String) -> Bool {
        //Check pattern match using Boyer Morre String search algo
        let stringArray = self.split(separator: " ")
        let queryArray = query.split(separator: " ")
        var isMatch: Bool = false
        for queryObject in queryArray {
            for stringObject in stringArray {
                let queryValue = String(queryObject).trimmingCharacters(in: .whitespaces).lowercased()
                let stringValue = String(stringObject).trimmingCharacters(in: .whitespaces).lowercased()
                let valueIndex = stringValue.index(of: queryValue)?.utf16Offset(in: stringValue)
                if valueIndex == 0 {
                    isMatch = true
                    break
                }
            }
            break
        }
        
        return isMatch
    }
}

// Date format For display in the screen
enum DateFormat: String {
    case movieListing = "yyyy-MM-dd"
    case userReview = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}
