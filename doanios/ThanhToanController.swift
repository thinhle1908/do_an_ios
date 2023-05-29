//
//  ThanhToanController.swift
//  doanios
//
//  Created by CNTT on 5/28/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class ThanhToanController: UIViewController {

    private var dao:DatabaseLayer?
    
    
    
    
    @IBAction func btnTestPro(_ sender: UIButton) {
        performSegue(withIdentifier: "goToBills", sender: self)
    }
    
    @IBOutlet weak var SoTien: UITextField!
    
    @IBOutlet weak var dateThanhToan: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoTien.text = String(total)
        
        dateThanhToan.text = ngay
        
        // Do any additional setup after loading the view.
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
