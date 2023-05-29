//
//  BanCollectionViewCell.swift
//  doanios
//
//  Created by Quang on 5/25/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class BanCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var tenBan: UILabel!
    weak var delegate: CollectionViewCellDelegate?
    var parameter: String?
    
    @IBAction func cellButtonPressed(_ sender: UIButton) {
        if let parameter = parameter {
            delegate?.didSelectItem(with: parameter)
        }
    }
}
protocol CollectionViewCellDelegate: AnyObject {
    func didSelectItem(with parameter: String)
}
