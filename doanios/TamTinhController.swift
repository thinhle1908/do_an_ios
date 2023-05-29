//
//  TamTinhController.swift
//  doanios
//
//  Created by CNTT on 5/28/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

var idBill:Int = 0
var detail:String = ""
var ngay:String = ""
var total:Int = 0

class TamTinhController: UIViewController {
    private var dao = DatabaseLayer()
     private var orderList = [Order]()
    
    @IBOutlet weak var chiTiet: UITextField!
    @IBOutlet weak var SoBan: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var TongTien: UITextField!
    var banso:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date() // Lấy thời gian hiện tại
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss" // Định dạng ngày tháng
        
        let dateString = dateFormatter.string(from: currentDate)
        date.text = dateString

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTest(_ sender: UIButton) {
                let bill = Bill(id: 10, date: date.text!, detail: chiTiet.text ?? "", total: Int(TongTien.text!) ?? 30000)
                idBill = (bill?.getId())!
                detail = (bill?.getDetail())!
                ngay = (bill?.getDate())!
                total = (bill?.getTotal())!
                dao = DatabaseLayer()
                let _ = dao.insert(bill: bill!)
             print("\(idBill)")
        
        performSegue(withIdentifier: "goToThanhToan", sender: self)
        
    }
    @IBAction func btnChonBan(_ sender: UIButton) {
//        let bill = Bill(id: 10, date: date.text!, detail: chiTiet.text ?? "", total: Int(TongTien.text!) ?? 30000)
//        idBill = (bill?.getId())!
//        detail = (bill?.getDetail())!
//        ngay = (bill?.getDate())!
//        total = (bill?.getTotal())!
//        dao = DatabaseLayer()
//        let _ = dao.insert(bill: bill!)
//   performSegue(withIdentifier: "GotoThanhToan", sender: self)
//     print("\(idBill)")
        let src = storyboard?.instantiateViewController(withIdentifier: "GoToThanhToan") as! ThanhToanController
        present(src, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ThanhToan" {
            if let destinationVC = segue.destination as? ThanhToanController{
                
            }
        }
    }
    
    
    @IBAction func btnChon(_ sender: UIButton) {
        let _ = dao.getOrderByTable(_orders: &orderList, _tableName: String(SoBan.text ?? ""))
        
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
