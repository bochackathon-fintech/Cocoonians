//
//  PromosViewController.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

enum PromoType{
    case newbaby
    case vacation
    case raise
    case wedding
}

struct Promo{
    let image:UIImage
    let title:String
    let description:String
    let type:PromoType
}

class PromosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let promos:[Promo] =
        [Promo(image: UIImage(named:"Baby")!, title: "Expecting?", description: "Your new baby is on its way. Open the baby savings account and prepare for a bright future!", type: .newbaby),
    Promo(image: UIImage(named:"Car")!, title: "Looking for a new car?", description: "A bigger family calls for a bigger car. You could be sitting behind the steering wheel of your new car faster than you might have imagined.", type: .newbaby),
    Promo(image: UIImage(named:"Holidays")!, title: "You’re going on a trip!", description: "Book your travel insurance for your trip and get rewarded with double points on your credit card!", type: .vacation),
    Promo(image: UIImage(named:"Raise")!, title: "You got a raise! Congrats!", description: "Open a new savings account and take advantage of our great interest rates. ", type: .raise),
    Promo(image: UIImage(named:"Wedding")!, title: "You’re getting married!", description: "Open the newlyweds account and save for a brighter future together.", type: .wedding)
    ]
    
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoTableViewCell.identifier, for: indexPath) as? PromoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.promo = promos[indexPath.row]
        
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
