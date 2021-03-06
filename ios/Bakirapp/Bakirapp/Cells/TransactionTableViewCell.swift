//
//  TransactionTableViewCell.swift
//  Bakirapp
//
//  Created by Silouanos on 10/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit
import SDWebImage

class TransactionTableViewCell: UITableViewCell {
    
    static let identifier = "TransactionTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    
    static let height = CGFloat(70)
    
    var transaction: Transaction! {
        didSet {
            if let icon = transaction.type?.icon,
                let iconUrl = URL(string: icon) {
                self.leftImageView.sd_setImage(with: iconUrl)
            }
            else if let merchantIcon = transaction.merchant?.type_icon,
                let iconUrl = URL(string: merchantIcon) {
                self.leftImageView.sd_setImage(with: iconUrl)
            }
            
            if let merchant = transaction.merchant {
                self.titleLabel.text = merchant.name
            }
            else {
                self.titleLabel.text = transaction.descr
            }
            self.amountLabel.text = "€ \(transaction.amount)"
            self.subtitleLabel.text = transaction.merchant?.type ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
