//
//  DishTableViewController.swift
//  doanios
//
//  Created by CNTT on 5/27/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class DishTableViewController: UITableViewController {
    
    //MARK: Properties
    private var dao:DatabaseLayer?
    
    @IBOutlet var tbList: UITableView!
    var dishes = [Dish]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Khoi tao cho dao
        dao = DatabaseLayer()
        
        //doc du lieu vao database meallist
        dao?.getAllDish(dishes: &dishes)
        
        //Create an example of meal
//        let image = UIImage(named: "AnhMau")
//        if let dish = Dish(name: "Ga nuong", price: 5, image: image){
//            dishes += [dish]
//        }
//        if let dish = Dish(name: "Trai cay", price: 5, image: image){
//            dishes += [dish]
//        }
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
        return dishes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "DishTableViewCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? DishTableViewCell {
            //lay du lieu de do vao table view
            let dish = dishes[indexPath.row]
            //do du lieu tu meal vao cell
            cell.dishName.text = dish.getName()
            cell.dishPrice.text = String(dish.getPrice())
            cell.dishImage.image = dish.getImage()
            cell.trashImage.addTarget(self, action: #selector(deleteRow(_:)), for: .touchUpInside)
            return cell
        }
        
        // Configure the cell...
        
        fatalError("Loi khong the tao cell")
    }
    
    @objc func deleteRow(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tbList)
        guard let indexPath = tbList.indexPathForRow(at: point)else{
            return
        }
        dao!.deleteDish(dish: dishes[indexPath.row])
        dishes.remove(at: indexPath.row)
        tbList.deleteRows(at: [indexPath], with: .left )
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        dishes.remove(at: indexPath.row)
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func unWindToDanhSachMon(segue: UIStoryboardSegue) {
        //LAY MAN HINH SOURCE(chinh la meal detail controller)
        if let source = segue.source as? DishViewController{
            if let dish = source.dish{
                
                switch source.navigationtype{
                case .adddish:
                    //ghi vao co so du lieu
                    let _ = dao!.insertDish(dish: dish)
                    
                    //them mon an moi vao table view cua meal list
                    print("adddish")
                    let newindexpath = IndexPath(row: dishes.count, section: 0)
                    dishes.append(dish)
                    tableView.insertRows(at: [newindexpath], with: .none)
                case .editdish:
                    //lay vi tri cell duoc chon truoc do
                    if let selectedIndexpath = tableView.indexPathForSelectedRow {
                        dao!.edit(oldDish: dishes[selectedIndexpath.row], newDish: dish)

                        //cap nhat meal moi vao
                        dishes[selectedIndexpath.row] = dish
                        
                        
                        //reload cell tai vi tri selectedIndexpath
                        tableView.reloadRows(at: [selectedIndexpath], with: .none)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //xac dinh duong di chuyen cua man hinh
        if let destination = segue.destination as? DishViewController{
            if let segueName = segue.identifier {
                
                if segueName == "addNewDishSegue" {
                    //print("them mon an moi ")
                    destination.navigationtype = .adddish
                }
                else{
                    destination.navigationtype = .editdish
                    //print("edit mon an ")
                    //lay vi tri tuong ung voi cell duoc chon
                    if let selectedIndexpath = tableView.indexPathForSelectedRow {
                        destination.dish = dishes[selectedIndexpath.row]
                        print("\(dishes[selectedIndexpath.row].getName())")
                    }
                }
            }
            else{
                print("chua dat ten cho segue")
            }
        }
    }

}
