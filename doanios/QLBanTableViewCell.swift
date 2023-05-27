//
//  QLBanTableViewCell.swift
//  doanios
//
//  Created by Quang on 5/26/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class QLBanTableViewCell: UITableViewCell {
    private var tableList = [Table]()
    private var dao:DatabaseLayer?
    @IBOutlet weak var txtBan: UILabel!
    @IBOutlet weak var btnSua: UIButton!
    @IBOutlet weak var btnXoa: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }

}
