//
//  PromotionsViewController.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: TransactionTableViewCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: TransactionTableViewCell.identifier)
            
        }
    }
    
    private var transactionsData = [String : [Transaction]]()
    private var transactionsDates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Transaction.fetchTransactions { (success) in
            DispatchQueue.main.async {
                self.configureTransactions()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureTransactions()
    {
        let context = ContextManager.shared.mainContext
        let transactions = Transaction.getAllTransactions(context: context)
        self.transactionsDates = transactions.map({
            return ($0.transaction_date as Date).getStringDate("dd, MMM yyyy")
        })
        
        _ = self.transactionsDates.enumerated().map({ (index, date) in
            if var transactionsForDate = transactionsData[date] {
                transactionsForDate.append(transactions[index])
            }
            else
            {
                transactionsData[date] = [transactions[index]]
            }
        })
        
//        _ = transactionsData.mapValues({ (transactions1) in
//            print("---> \(transactions1)")
//        })
//
//        _ = self.transactionsDates.map({print("tr date \($0)")})
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TransactionTableViewCell.height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.transactionsDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionsData[self.transactionsDates[section]]?.count  ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as? TransactionTableViewCell else {
            return UITableViewCell()
        }
        let date = self.transactionsDates[indexPath.section]
        if let transactions = self.transactionsData[date]
        {
            cell.transaction = transactions[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320, height: 30))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15.0, y: 0.0, width: 320, height: 30))
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.transactionsDates[section]
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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


