//
//  GoiMonCollectionViewCell.swift
//  doanios
//
//  Created by Minh on 5/23/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class GoiMonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMonAn: UIImageView!
    @IBAction func btnGiamSoLuong(_ sender: UIButton) {
    }
    
    @IBAction func btnTangSoLuong(_ sender: UIButton) {
    }
    @IBOutlet weak var tenMonAn: UILabel!
    @IBOutlet weak var soLuongMon: UITextField!
    @IBOutlet weak var giaMonAn: UILabel!
}
