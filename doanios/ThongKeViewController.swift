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
    private var moneyCount:Int = 0
    
    
    @IBOutlet weak var lbSoHangBan: UILabel!
    @IBOutlet weak var lbSoDonHang: UILabel!
    @IBOutlet weak var lbTongTienThu: UILabel!
    @IBOutlet weak var lbSoBan: UILabel!
    @IBOutlet weak var lbTongSoMonAn: UILabel!
    
    public func get4KindData(){
        
        dao?.getAllOrder(_orders: &orderList)
        dao?.getAllDish(dishes: &dishList)
        dao?.getAllTable(_tables: &tableList)
        dao?.getAllBill(bills: &billList)
        
        
    }
    
    public func count(){
       orderCount = orderList.count
        tableCount = tableList.count
        dishCount = dishList.count
        billCount = billList.count
        for bill in billList{
            moneyCount += bill.getTotal()
        }
        print("Count order: ",orderCount)
        print("Count table: ",tableCount)
        print("Count dish: ",dishCount)
        print("Count bill: ",billCount)
        print("Count money: ",moneyCount)
    }
    
    public func setValueToLabel(){
        
        lbSoHangBan.text = String(orderCount)
        lbSoBan.text = String(tableCount)
        lbSoDonHang.text = String(billCount)
        lbTongSoMonAn.text = String(dishCount)
        lbTongTienThu.text = String(moneyCount)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dao = DatabaseLayer()
        get4KindData()
        count()
        setValueToLabel()
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
