//
//  ThognKeViewController.swift
//  doanios
//
//  Created by Minh on 5/28/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class ThongKeViewController: UIViewController {

    private var dao:DatabaseLayer?
    private var orderList = [Order]()
    private var dishList = [Dish]()
    private var tableList = [Table]()
    private var billList = [Bill]()
    
    private var billCount:Int = 0
    private var orderCount:Int = 0
    private var tableCount:Int = 0
    private var dishCount:Int = 0
    
    public func get4Kindata(){
        
        dao?.getAllOrder(_orders: &orderList)
        dao?.getAllDish(dishes: &dishList)
        dao?.getAllTable(_tables: &tableList)
        dao?.getAllBill(bills: &billList)
        
        
    }
    
    public func count(){
       orderCount = orderList.count
        tableCount = tableList.count
        dishCount = dishList.count
        
        for bill in billList{
            billCount += bill.getTotal()
        }
    }
    
    public func setValueToLabel(){
        /*
        lblTotalOrder.text = String(orderCount)
        lblTotalDish.text = String(orderCount)
        lblTotalTable.text = String(orderCount)
        lblTotalBill.text = String(orderCount)
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
