//
//  GoiMonViewController.swift
//  doanios
//
//  Created by Minh on 5/23/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//
import os.log
import UIKit

class GoiMonViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{

    /*
     
     
     */
    
    
    
    private var orderList = [Order]()
    private var dao:DatabaseLayer?
    private var dishList = [Dish]()
    
            var tableName:String? = ""
    private var tongTien:Int = 0
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishList.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goiMonCell", for: indexPath) as! GoiMonCollectionViewCell
        cell.tenMonAn.text = dishList[indexPath.item].getName()
        cell.imgMonAn.image = dishList[indexPath.item].getImage()
        cell.soLuongMon.text = "0"
        let tempPrice = dishList[indexPath.item].getPrice()
        let tempName = dishList[indexPath.item].getName()
        
        for donHang in orderList{
            if(tempName == donHang.getName()){
                tongTien += tempPrice * donHang.getQuantity()
                cell.soLuongMon.text = String(donHang.getQuantity())
                os_log("tim duoc 1 mon an trung khop")
            }
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 220) //không được sửa width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Touched: \(indexPath)");
        
    }
    
    @IBOutlet weak var coll: UICollectionView!
    
    @IBAction func btnTangSoLuong(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? GoiMonCollectionViewCell{
            if var value = Int(cell.soLuongMon.text ?? "0") {
                // Tăng giá trị lên 1
                value += 1
                
                // Cập nhật giá trị mới cho UITextField
                cell.soLuongMon.text = String(value)
            }
        }
    }
    
    @IBAction func btnGiamSoLuong(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? GoiMonCollectionViewCell {
            if var value = Int(cell.soLuongMon.text ?? "0") {
                // Giảm giá trị đi 1 đơn vị, nhưng không cho phép giảm dưới 0
          	      value = max(value - 1, 0)
                
                // Cập nhật giá trị mới cho UITextField
                cell.soLuongMon.text = String(value)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        coll.dataSource = self;
        coll.delegate = self;
        coll.reloadData()
        // Do any additional setup after loading the view.
        dao = DatabaseLayer()
//        dao?.superDelete(tableNameWantToDelete: "oder")
//        dao?.superDelete(tableNameWantToDelete: "dish")
        
        
        
        dao?.getAllDish(dishes: &dishList)
        //dao?.getOrderByTable(_orders: &orderList, _tableName: tableName!)
        dao?.getAllOrder(_orders: &orderList)
        print("Dish count :" ,dishList.count)
        print("order count :" ,orderList.count)
        if let tableName = tableName {
           print("",tableName)
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
