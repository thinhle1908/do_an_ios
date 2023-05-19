//
//  LoginViewController.swift
//  doanios
//
//  Created by CNTT on 5/19/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var tf_nhapmapin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Chinh text filed nhap ma pin
        underLineTextField()

        // Do any additional setup after loading the view.
    }
    func underLineTextField() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: -15, y: 30, width: 200, height: 1.0)

        bottomLine.backgroundColor = UIColor.black.cgColor
        tf_nhapmapin.layer.addSublayer(bottomLine)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
