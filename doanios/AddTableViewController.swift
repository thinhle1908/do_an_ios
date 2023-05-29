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
    var oldName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (headerTitle != "") {
            self.title = headerTitle
            txtBan.text = tableData?.getName()
        }
        oldName = txtBan.text
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnThemban(_ sender: Any) {
        if (headerTitle != "") {
            print("Quang \(oldName)")
            let table = Table(id: tableData!.id, name: txtBan.text!)
            dao = DatabaseLayer()
            let _ = dao!.updateTable(oldName: oldName!, _table: table!)
        }
        else {
            let table = Table(id: "", name: txtBan.text!)
            dao = DatabaseLayer()
            let _ = dao!.insertTable(table: table!)
            
        }
    }
    
    private func updateSavestate(){
        let name = txtBan.text ?? ""
        
        if(!name.isEmpty){
            btnBan.isEnabled = true
        }
        else{
            btnBan.isEnabled = false
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
