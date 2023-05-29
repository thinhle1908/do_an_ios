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
    
    private var orderList = [Order]()
    private var dao:DatabaseLayer?
    private var dishList = [Dish]()
    private var orderListUpdate = [Order]()
    public var tableName:String? = "ban 2"
    private var tongTien:Int = 0
    
    
    //Lấy dữ liệu món ăn ra chuyển vào cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishList.count    }
    
    //Nạp dữ liệu từ đata ra để gắn vào cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goiMonCell", for: indexPath) as! GoiMonCollectionViewCell
        
        //-Bắt đầu set dữ liệu cho các thuộc tính của side-
        cell.tenMonAn.text = dishList[indexPath.item].getName()
        cell.imgMonAn.image = dishList[indexPath.item].getImage()
        cell.soLuongMon.text = "0"
        let tempPrice = dishList[indexPath.item].getPrice()
        let tempName = dishList[indexPath.item].getName()
        
        //-Câu lệnh này nghĩa là duyệt tất cả các order, cái nào match =name thì móc số lượng của nó ra và add vào cell (ở đây chỉ có các order chưa được tính tiền mới được thêm vào thui)-//
        for donHang in orderList{
            if(tempName == donHang.getName()){
                tongTien += tempPrice * donHang.getQuantity()
                cell.soLuongMon.text = String(donHang.getQuantity())
                os_log("tim duoc 1 mon an trung khop")
            }
        }
        return cell;
    }
    
    //set layout
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
    
    @IBAction func btnCapNhat(_ sender: UIBarButtonItem) {
        for order in orderListUpdate{
            dao = DatabaseLayer()
            dao?.updateOrderS(orderListUpdate)
            dao?.deleteOrders(orderList)
        }
        showAlertDialog()
    }
    
    func getDataFromCollectionView(){
        // Duyệt qua tất cả các cell trong UICollectionView
        for section in 0..<coll.numberOfSections {
            for item in 0..<coll.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                if let cell = coll.cellForItem(at: indexPath) as? GoiMonCollectionViewCell{
                    let upName = cell.tenMonAn.text ?? ""
                    let upQuantity = Int(cell.soLuongMon.text ?? "")
                    let upState = "chuathanhtoan"
                    var tempOrder:Order = Order(name: upName, table: tableName!, state: upState, quantity: upQuantity!, price: 0)!
                    orderListUpdate.append(tempOrder)
                }
             
            }
        }
    }
    func pushUpdateDataToServe(){
        
        
        
    }
    
    func showAlertDialog() {
        // Tạo UIAlertController với title, message và style
        let alertController = UIAlertController(title: "Thông báo", message: "Đã cập nhật dữ liệu", preferredStyle: .alert)
        
        // Tạo action cho UIAlertController
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Xử lý khi người dùng nhấn OK
            self.dismiss(animated: true, completion: nil)
            
        }
        
        // Thêm action vào UIAlertController
        alertController.addAction(okAction)
        
        // Hiển thị UIAlertController lên màn hình
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coll.dataSource = self;
        coll.delegate = self;
        coll.reloadData()
        //Khởi tạo database
        dao = DatabaseLayer()
        
        // * Bắt đầu lấy dữ liệu từ dứoi database * //
        dao?.getAllDish(dishes: &dishList)
        dao?.getOrderByTable(_orders: &orderList, _tableName: tableName!)
        //dao?.getAllOrder(_orders: &orderList)
        print("Dish count :" ,dishList.count)
        print("Order count :" ,orderList.count)
//      print("Order 1 :" ,orderList[0].getTable())
//      print("Order 2 :" ,orderList[1].getTable())
//      print("Order 3 :" ,orderList[2].getTable())
//      print("Order 4 :" ,orderList[3].getTable())
//      print("Order 5 :" ,orderList[4].getTable())
//      print("Order 6 :" ,orderList[5].getTable())
        print("-_-_-_ END ViewDidLoad of GOI MON _-_-_-")
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
