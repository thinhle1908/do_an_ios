//
//  AddTableViewController.swift
//  doanios
//
//  Created by Quang on 5/26/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class AddTableViewController: UIViewController {
    private var dao:DatabaseLayer?
    @IBOutlet weak var txtBan: UITextField!
    
    @IBOutlet weak var btnBan: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTable(_ sender: Any) {
        let table = Table(name: txtBan.text!)
        dao = DatabaseLayer()
        let _ = dao!.insertTable(table: table!)
        
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
