//
//  String+Extension.swift
//  MoviesInformationApp
//
//  Created by Akshuma Trivedi on 02/07/21.
//

import Foundation

extension String {
    
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
}

enum DateFormat: String {
    case movieListing = "yyyy-MM-dd"
    case userReview = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
}
