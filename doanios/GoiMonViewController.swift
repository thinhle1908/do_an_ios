//
//  GoiMonViewController.swift
//  doanios
//
//  Created by Minh on 5/23/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class GoiMonViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{

    
    
    
    private var orderList = [Order]()
    private var dao:DatabaseLayer?
    
    var order1:Order? = Order(name: "Com ga 1",table: "2", state: "chuaThanhToan", quantity: 3, price: 1000)
    var order2:Order? = Order(name: "Com ga 2",table: "2", state: "chuaThanhToan", quantity: 3, price: 1000)
    
    
    //GET DATA
    let data = ["Com ga 1","Com ga 2","Com ga 3","Com ga 4","Com ga 5","Com ga 6",]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goiMonCell", for: indexPath) as! GoiMonCollectionViewCell
        cell.tenMonAn.text = data[indexPath.row]
        cell.imgMonAn.image = #imageLiteral(resourceName: "imgComGa")
        cell.soLuongMon.text = 
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 220) //không được sửa width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Touched: \(indexPath)");
        
    }
    
    @IBOutlet weak var coll: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coll.dataSource = self;
        coll.delegate = self;
        coll.reloadData()
        // Do any additional setup after loading the view.
        orderList.append(order1!)
        orderList.append(order2!)
        
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
