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
    @IBOutlet weak var subamountLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    
    static let height = CGFloat(70)
    
    var transaction: Transaction! {
        didSet {
            if let icon = transaction.type?.icon,
                let iconUrl = URL(string: icon) {
                self.leftImageView.sd_setImage(with: iconUrl)
            }
            self.titleLabel.text = transaction.descr
            self.amountLabel.text = "€ \(transaction.amount)"
            //self.subtitleLabel.text = transaction.
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
