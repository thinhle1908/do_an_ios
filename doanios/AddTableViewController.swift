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
    var tableData: Table?
    @IBOutlet weak var txtBan: UITextField!
    var headerTitle = ""
    @IBOutlet weak var btnBan: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (headerTitle != "") {
            self.title = headerTitle
            txtBan.text = tableData?.getName()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnThemban(_ sender: Any) {
        if (headerTitle != "") {
            let table = Table(id: tableData!.id, name: txtBan.text!)
            dao = DatabaseLayer()
            let _ = dao!.updateTable(_table: table!, tenBan: txtBan.text!)
        }
        else {
            let table = Table(id: "", name: txtBan.text!)
            dao = DatabaseLayer()
            let _ = dao!.insertTable(table: table!)
            
        }
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
