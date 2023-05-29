//
//  BanViewController.swift
//  doanios
//
//  Created by Quang on 5/25/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class BanViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    var  mysideMenu = false
    private var tableList = [Table]()
    private var dao:DatabaseLayer?
    @IBOutlet weak var leadingConst: NSLayoutConstraint!
    
    let data = ["Ban 1","Ban 2","Ban 3","Ban 4","Ban 5","Ban 6",]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let table = tableList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "goiBanCell", for: indexPath) as! BanCollectionViewCell
        cell.tenBan.text = table.getName()
        cell.layer.cornerRadius = 10
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 98) //không được sửa width
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Touched: \(indexPath)");
        
    }

    
    @IBOutlet weak var coll: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        coll.dataSource = self;
        coll.delegate = self;
        dao = DatabaseLayer()
        dao?.getAllTable(_tables: &tableList)
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        print("Quang")
        if (mysideMenu) {
            leadingConst.constant = -240
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else
        {
            leadingConst.constant = 0
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })
            
        }
        mysideMenu = !mysideMenu
    }
    
    

}
