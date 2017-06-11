//
//  PromoTableViewCell.swift
//  Bakirapp
//
//  Created by Elena Georgiou on 11/06/2017.
//  Copyright © 2017 Cocoonians. All rights reserved.
//

import UIKit

class PromoTableViewCell: UITableViewCell {
    
    static let identifier = "PromoTableViewCell"
    
    @IBOutlet weak var promoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    
    var promo: Promo! {
        didSet {
            promoImageView.image = promo.image
            titleLabel.text = promo.title
            descrLabel.text = promo.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
