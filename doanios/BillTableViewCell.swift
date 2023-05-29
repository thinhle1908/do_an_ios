//
//  BillTableViewCell.swift
//  doanios
//
//  Created by CNTT on 5/29/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTotal: UILabel!
    
   
    @IBOutlet weak var lbDetail: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
