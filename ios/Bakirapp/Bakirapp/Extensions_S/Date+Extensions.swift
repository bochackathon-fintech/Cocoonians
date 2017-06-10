//
//  Date+Extensions.swift
//  Stagedoor
//
//  Created by Elena Georgiou on 23/01/2016.
//  Copyright © 2016 Stagedoor. All rights reserved.
//

import Foundation

extension Date{
    
    func getStringDate(_ format:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: self)
    }
    
    static func getDateFromString(_ dateFormat: String, dateString: String) -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat /*17, Dec 2014 - 19:30*/
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let start_date = dateFormatter.date(from: dateString){
            return start_date
        }
        
        return nil
    }
}
