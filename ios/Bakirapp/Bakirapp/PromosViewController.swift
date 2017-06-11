//
//  PromosViewController.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

enum PromoType: String{
    case newbaby = "baby"
    case vacation = "vacation"
    case raise = "raise"
    case wedding = "wedding"
}

struct Promo{
    let image:UIImage
    let title:String
    let description:String
    let type:PromoType
}

class PromosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let nib = UINib(nibName: PromoTableViewCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: PromoTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PromotionsSingleton.shared.possiblePromos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoTableViewCell.identifier, for: indexPath) as? PromoTableViewCell else {
            return UITableViewCell()
        }
        cell.promo = PromotionsSingleton.shared.possiblePromos[indexPath.row]        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Do you want to contact your banker?", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Call Now", style: UIAlertActionStyle.default, handler: { (action) in
            guard let number = URL(string: "tel://80000800") else { return }
            UIApplication.shared.open(number)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            
        }))
        present(alertController, animated: true, completion: nil)
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
