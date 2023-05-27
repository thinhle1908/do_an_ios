//
//  QLBanViewController.swift
//  doanios
//
//  Created by Quang on 5/26/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class QLBanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    private var tableList = [Table]()
    private var dao:DatabaseLayer?
    
    @IBOutlet weak var collban: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collban.delegate = self
        collban.dataSource = self
        dao = DatabaseLayer()
        dao?.getAllTable(_tables: &tableList)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let table = tableList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "QLBanTableViewCell") as! QLBanTableViewCell
       
        cell.txtBan.text = table.getName()
        cell.btnSua.tag = indexPath.row
        cell.btnXoa.tag = indexPath.row
        cell.btnSua.addTarget(self, action: #selector(onclickEdit(_:)), for: .touchUpInside)
        cell.btnXoa.addTarget(self, action: #selector(onclickDelete(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func onclickEdit(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddTableViewController") as! AddTableViewController
        vc.table = tableList[sender.tag]
        vc.headerTitle = "Update"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func onclickDelete(_ sender: UIButton) {
        
        dao = DatabaseLayer()
        let _ = dao!.deleteTable(_table: tableList[sender.tag])
        tableList.remove(at: sender.tag)
        collban.reloadData()
    }

}
