//
//  ViewController.swift
//  doanios
//
//  Created by CNTT on 5/18/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mysideMenu = false
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnMenu(_ sender: Any) {
        if (mysideMenu) {
            leadingConst.constant = -240
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else
        {
            leadingConst.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })

        }
        mysideMenu = !mysideMenu
    }
}

