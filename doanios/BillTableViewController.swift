//
//  BillTableViewController.swift
//  doanios
//
//  Created by CNTT on 5/29/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class BillTableViewController: UITableViewController {
    
    
    private var billList = [Bill]()
    private var dao:DatabaseLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dao = DatabaseLayer()
        
        //doc du lieu vao database meallist
        dao?.getAllBill(bills: &billList)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return billList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "BillTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? BillTableViewCell {
            //lay du lieu de do vao table view
            let bill = billList[indexPath.row]
            //do du lieu tu meal vao cell
            cell.lbTotal.text = String(bill.getTotal())
            cell.lbDetail.text = bill.getDetail()
            cell.lbDate.text = bill.getDate()
            print("detail is \(bill.getDetail())")
            return cell
        }
        
        // Configure the cell...
        
        fatalError("Loi rau")
    }
    
    
    
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    
//
//
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            billList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
//
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}
