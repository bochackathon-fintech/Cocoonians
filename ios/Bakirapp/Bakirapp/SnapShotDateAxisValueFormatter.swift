//
//  SnapShotDateAxisValueFormatter.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import Foundation
import Charts

class SnapShotDateAxisValueFormatter:NSObject, IAxisValueFormatter{
    
    var dataSet:[SnapShot]
    
    
    override init(){
        dataSet = []
        
        super.init()
    }
    
    convenience init(set:[SnapShot]){
        self.init()
        self.dataSet = set
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        let snapshot = dataSet[index]
        
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.short
        formatter.timeStyle = DateFormatter.Style.none
        formatter.dateFormat = "dd/MM"
        
        return formatter.string(from: snapshot.date as Date)
    }
}
