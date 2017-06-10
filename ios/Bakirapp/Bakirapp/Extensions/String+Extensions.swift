//
//  String+Extensions.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import Foundation
extension String {
    var toDate:Date? {
        //"31, Mar 2006";
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
        dateFormatter.dateFormat = "dd, MMM yyyy - HH:mm:ssZ"
        if let date =  dateFormatter.date(from: self) {
            return date
        }
        
        dateFormatter.dateFormat = "dd',' MMM yyyy - HH:mm'.'ZZZZ"
        if let date = dateFormatter.date(from: self) {
            return date
        }
        
        dateFormatter.dateFormat = "dd',' MMM yyyy - HH:mm:ss"
        if let date =  dateFormatter.date(from: self) {
            
            
            return date
        }
        
        //2017-06-10T09:41:27.200785Z
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date =  dateFormatter.date(from: self) {
            return date
        }
        
        //2017-06-01
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date =  dateFormatter.date(from: self) {
            return date
        }
        
        dateFormatter.dateFormat = "dd, MMM yyyy"
        if let date =  dateFormatter.date(from: self) {
            return date
        }
        
        
        dateFormatter.dateFormat = "HH:mm:ss"
        if let date =  dateFormatter.date(from: self) {
            return date
        }
        
        
        
        //"27, Sep 2016 - 09:51.+0000"
        
        
        
        
        
        return nil
    }
    
    
    
    
    var nullify:String? {
        return self.isEmpty ? nil : self
    }
    
}
