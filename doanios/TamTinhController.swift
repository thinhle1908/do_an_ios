//
//  TamTinhController.swift
//  doanios
//
//  Created by CNTT on 5/24/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class TamTinhController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        
    }
    @IBAction func thanhtoan(_ sender: UIButton) {
       performSegue(withIdentifier: "GotoThanhToan", sender: self)
        
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
