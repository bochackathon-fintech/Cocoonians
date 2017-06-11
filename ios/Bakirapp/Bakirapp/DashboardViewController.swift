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
    @IBOutlet weak var balanceAmountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.navigationItem.title = "Account"
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"bell"), style: .done, target: nil, action: nil)
        
        Account.fetchAccounts { (succes, accounts) in
            DispatchQueue.main.async {
                
                self.drawChart()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func drawChart(){
        //lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.xAxis.enabled = true
        lineChartView.maxVisibleCount = 10
        lineChartView.legend.form = .none
        lineChartView.backgroundColor = UIColor.bakirBlue()
        lineChartView.animate(xAxisDuration: 1.5)
//        lineChartView.animate(xAxisDuration: 1.5, easingOption: ChartEasingOption.easeInElastic)
        
        
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        
        let request = NSFetchRequest<Account>(entityName: Account.className)
        
        do{
            let accounts = try ContextManager.shared.mainContext.fetch(request)
            
            if let account = accounts.first{
                self.tabBarController?.navigationItem.title = "\(account.name)"
                
                let balance = String(format: "%.2f",account.balance)
                       
                self.balanceAmountLabel.text = "€\(balance)"
                
                let request2 = NSFetchRequest<SnapShot>(entityName: SnapShot.className)
                request2.predicate = NSPredicate(format: "account = %@", account)
                request2.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
                let snapshots = try ContextManager.shared.mainContext.fetch(request2)
                
                var yVals:[ChartDataEntry] = []
                
                
                let xAxis = lineChartView.xAxis
                xAxis.granularity = 1.0
                xAxis.labelCount = 7
                xAxis.enabled = true
                xAxis.labelPosition = .bottom
                xAxis.drawGridLinesEnabled = false
                xAxis.labelTextColor = UIColor.white
                xAxis.labelFont = UIFont.boldSystemFont(ofSize: 10)
                
                
//
                let rightAxisFormatter = NumberFormatter()
                rightAxisFormatter.negativePrefix = "-€"
                rightAxisFormatter.positivePrefix = "€"
                
                let rightAxis = lineChartView.rightAxis
                //rightAxis.gridColor = UIColor.white
                rightAxis.drawGridLinesEnabled = false
                rightAxis.labelTextColor = UIColor.white
                rightAxis.labelFont = UIFont.boldSystemFont(ofSize: 10)
                rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: rightAxisFormatter)
             
                
                xAxis.valueFormatter = SnapShotDateAxisValueFormatter(set: snapshots)
                
                for (i,snapshot) in snapshots.enumerated(){
                    let lineChartEntry = ChartDataEntry(x: Double(i), y: Double(snapshot.balance))
                    
                    
                    yVals.append(lineChartEntry)
                }
                
                let set = LineChartDataSet(values: yVals, label: nil)
                set.drawCirclesEnabled = false
                set.mode = .cubicBezier
                set.lineWidth = 4.0
                set.highlightEnabled = false
                set.setColor(UIColor.white)
                let data = LineChartData()
                data.addDataSet(set)
                
                
                lineChartView.data = data
                
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
