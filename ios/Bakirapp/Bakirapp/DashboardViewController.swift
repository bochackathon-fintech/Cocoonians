//
//  DashboardViewController.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import Charts
import CoreData

class DashboardViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Account.fetchAccounts { (succes, accounts) in
            DispatchQueue.main.async {
                self.drawChart()
            }
        }
    }
    
    func drawChart(){
        
        
        let request = NSFetchRequest<Account>(entityName: Account.className)
        do{
            let accounts = try ContextManager.shared.mainContext.fetch(request)
            if let account = accounts.first, let snapshots = account.snapshots?.allObjects as? [SnapShot]{
                
//                var xVals:[String] = []
//                let formatter = DateFormatter()
//                formatter.dateStyle = DateFormatter.Style.short
//                formatter.timeStyle = DateFormatter.Style.none
//                
//                for snapshot in snapshots{
//                    xVals.append(formatter.string(from: snapshot.date as Date))
//                }
                
                var yVals:[ChartDataEntry] = []
                
                for (i,snapshot) in snapshots.enumerated(){
                    let lineChartEntry = ChartDataEntry(x: Double(i), y: Double(snapshot.balance)) 
                    
                    
                    yVals.append(lineChartEntry)
                }
                
                let set = LineChartDataSet(values: yVals, label: nil)
                let data = LineChartData()
                data.addDataSet(set)
                
                
            }
        }
        catch{
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }                      
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
