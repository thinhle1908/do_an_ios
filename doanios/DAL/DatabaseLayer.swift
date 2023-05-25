//
//  DatabaseLayer.swift
//  doanios
//
//  Created by Minh on 5/24/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import Foundation
import UIKit
import os.log

//********************************************************************************************************
//
//********************************************************************************************************

class DatabaseLayer{
    private let DB_NAME = "Doan.sqlite"
    private let DB_PATH:String?
    private let database:FMDatabase?

    
    //Mark: Table properties
    //1. Order
    private let ORDER_TABLE_NAME = "oder"
    private let ORDER_ID = "_id"
    private let ORDER_NAME = "name"
    private let ORDER_PRICE = "value"
    private let ORDER_QUANTITY = "quantity"
    private let ORDER_TABLE = "tableName"
    private let ORDER_STATE = "state"
    //2. Dish
    private let DISH_TABLE_NAME = "dish"
    private let DISH_ID = "_id"
    private let DISH_NAME = "name"
    private let DISH_PRICE = "value"
    private let DISH_IMAGE = "image"
    //3. Table
    private let TABLE_TABLE_NAME = "table"
    private let TABLE_ID = "_id"
    private let TABLE_NAME = "tableName"
    //4. Bill
    private let BILL_TABLE_NAME = "bill"
    private let BILL_ID = "_id"
    private let BILL_DETAIL = "billDetail"
    private let BILL_DATE = "billDate"
    private let BILL_TOTAL = "billTotal"
    
    //Mark: Contructor
    init(){
        let directions:[String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true);
        //Khoi tao DB DBPATH\
        DB_PATH = directions[0] + "/" + DB_NAME;
        //Khoi tao Database
        database = FMDatabase(path: DB_PATH)
        // Thông báo cho người dùng tình trạng database
        if database != nil {
            os_log("Database created succesfuly");
            // TAO bang
            let _ = createTable();
        }else {
            os_log("Database creation failure");
        }
    }
    
    private func isDatabaseCreated()->Bool{
        return (database != nil)
    }
    
    //3. Dong mo CSDL
    private func open() -> Bool{
        var ok = false;
        if isDatabaseCreated(){
            if database!.open(){
                ok = true
                os_log("Database open succesfuly")
            }else{
                os_log("Database open failure")
            }
        }
        return ok;
    }
    private func close() -> Bool{
        var ok = false;
        if isDatabaseCreated(){
            if database!.close(){
                ok = true
                os_log("Database was closed")
            }else{
                os_log("Database closing failure")
            }
        }
        return ok;
    }
    
    //4. Tao cac bang du lieu
    private func createTable()-> Bool{
        var ok = false;
        let sql1 = "CREATE TABLE \(ORDER_TABLE_NAME)("
            + ORDER_ID + " INTEGER PRIMARY KEY AUTO INCREAMENT, "
            + ORDER_NAME + " TEXT, "
            + ORDER_PRICE + " INTEGER, "
            + ORDER_STATE + " TEXT, "
            + ORDER_QUANTITY + " INTEGER, "
            + ORDER_TABLE + " TEXT)"
        
        let sql2 = "CREATE TABLE \(DISH_TABLE_NAME)("
            + DISH_ID + " INTEGER PRIMARY KEY AUTO INCREAMENT, "
            + DISH_NAME + " TEXT, "
            + DISH_PRICE  + " INTEGER, "
            + DISH_IMAGE + " TEXT)"
        
        let sql3 = "CREATE TABLE \(TABLE_TABLE_NAME)("
            + TABLE_ID + " INTEGER PRIMARY KEY AUTO INCREAMENT, "
            + TABLE_NAME + " TEXT)"
        
        let sql4 = "CREATE TABLE \(BILL_TABLE_NAME)("
            + BILL_ID + " INTEGER PRIMARY KEY AUTO INCREAMENT, "
            + BILL_DETAIL + " TEXT, "
            + BILL_TOTAL + " INTEGER, "
            + BILL_DATE + " TEXT)"
        
        //THUC THI CAU LENH SQL
        
        if( open()){
            database!.executeStatements(sql1);
            database!.executeStatements(sql2);
            database!.executeStatements(sql3);
            database!.executeStatements(sql4);
            ok = true;
            os_log("ALL tables create suscesfuly")
        } else {
            os_log("cannot create table")
        }
        return ok;
    }
    
    //****************************
    // DINH NGHIA CAC HAM API
    //****************************
    
    //****************************
    // Mark: CRUD CHO BANG ORDER
    //****************************
    public func insertOrder(_order:Order)->Bool{
        var ok = false
        
        let sql = "INSERT INTO \(ORDER_TABLE_NAME) ("
            + ORDER_NAME + " , "
            + ORDER_PRICE + " , "
            + ORDER_STATE + " , "
            + ORDER_QUANTITY + " , "
            + ORDER_TABLE + ") "
            + "VALUE (?,?,?,?,?)"
        //Thuc hien cau lenh SQL
        if open(){
            database!.executeUpdate(sql, withArgumentsIn: [_order.getName(), _order.getPrice(), _order.getState(), _order.getQuantity() ,_order.getTable()])
            ok = true
            os_log("Add new ORDER succesfuly")
            let _ = close();
        }else{
            os_log("Can't write data")
        }
        
        return ok
    }
    
    public func getAllOrder(_orders:inout[Order]){
        //thuc hien doc du lieu
        if (open()){
            let sql = "SELECT * FROM \(ORDER_TABLE_NAME)"
            var result:FMResultSet?
            // Xu ly ngoai le
            do{
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("Error when trying to read database")
            }
            //Xu ly ket qua dat duoc
            if let result = result {
                while (result.next()){
                    let name = result.string(forColumn: ORDER_NAME) ?? ""
                    let price = result.int(forColumn: ORDER_PRICE)
                    let state = result.string(forColumn: ORDER_STATE) ?? ""
                    let quantity = result.int(forColumn: ORDER_QUANTITY)
                    let table = result.string(forColumn: ORDER_TABLE) ?? ""
                   
                    //tao bien order da doc duoc
                    if let order = Order(name: name, table: String(table), state: state, quantity: Int(quantity), price: Int(price)){
                        //luu vao mang tham bien
                        _orders.append(order)
                    }
                }
            }
            let _ = close()
        }
    }
    
    //Lay cac don hang chua thanh toan (dang doi tinh tien)
    public func getOrderByTable(_orders:inout[Order],_tableName:String){
        
        //thuc hien doc du lieu
        if (open()){
            let sql = "SELECT * FROM \(ORDER_TABLE_NAME) WHERE \(ORDER_TABLE) = \(_tableName) AND \(ORDER_STATE) = `chuathanhtoan`"
            var result:FMResultSet?
            // Xu ly ngoai le
            do{
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("Error when trying to read database")
            }
            //Xu ly ket qua dat duoc
            if let result = result {
                while (result.next()){
                    let name = result.string(forColumn: ORDER_NAME) ?? ""
                    let price = result.int(forColumn: ORDER_PRICE)
                    let state = result.string(forColumn: ORDER_STATE) ?? ""
                    let quantity = result.int(forColumn: ORDER_QUANTITY)
                    let table = result.string(forColumn: ORDER_TABLE) ?? ""
                    
                    //tao bien order da doc duoc
                    //name:String,table:String,state:String,quantity:Int,price:Int)
                    if let order = Order(name: name, table: String(table), state: state, quantity: Int(quantity), price: Int(price)){
                        //luu vao mang tham bien
                        _orders.append(order)
                    }
                }
            }
            let _ = close()
        }
    }
    
    
    //Xoa cac don hang theo ten mon an và bàn
    func deleteOrders(_ orders: [Order]) {
        // Mở kết nối với cơ sở dữ liệu
        if open() {
            // Lặp qua mảng các đối tượng Order
            for order in orders {
                let sql = "DELETE FROM \(ORDER_TABLE_NAME) WHERE \(ORDER_NAME) = ? AND \(ORDER_TABLE) = ?"
                
                // Xử lý ngoại lệ
                do {
                    // Thực hiện câu lệnh SQL
                    try database?.executeUpdate(sql, values: [order.getName(), order.getTable()])
                } catch {
                    print("Error when trying to delete order: \(error.localizedDescription)")
                }
            }
            
            // Đóng kết nối với cơ sở dữ liệu
            let _ = close()
        }
    }
    
    //tinh tien
    func updateOrdersToPaid(_ orders: [Order]) {
        // Mở kết nối với cơ sở dữ liệu
        if open() {
            // Lặp qua mảng các đối tượng Order
            for order in orders {
                let sql = "UPDATE \(ORDER_TABLE_NAME) SET \(ORDER_STATE) = 'dathanhtoan' WHERE \(ORDER_NAME) = ? AND \(ORDER_TABLE) = ?"
                
                // Xử lý ngoại lệ
                do {
                    // Thực hiện câu lệnh SQL
                    try database?.executeUpdate(sql, values: [order.getName(), order.getTable()])
                } catch {
                    print("Error when trying to update order: \(error.localizedDescription)")
                }
            }
            
            // Đóng kết nối với cơ sở dữ liệu
            let _ = close()
        }
    }
    
    //Van la tinh tien nhung duoc goi voi cai ten khac
    func tinhTien(_ orders: [Order]) {
        // Mở kết nối với cơ sở dữ liệu
        if open() {
            // Lặp qua mảng các đối tượng Order
            for order in orders {
                let sql = "UPDATE \(ORDER_TABLE_NAME) SET \(ORDER_STATE) = 'dathanhtoan' WHERE \(ORDER_NAME) = ? AND \(ORDER_TABLE) = ?"
                
                // Xử lý ngoại lệ
                do {
                    // Thực hiện câu lệnh SQL
                    try database?.executeUpdate(sql, values: [order.getName(), order.getTable()])
                } catch {
                    print("Error when trying to update order: \(error.localizedDescription)")
                }
            }
            
            // Đóng kết nối với cơ sở dữ liệu
            let _ = close()
        }
    }
    
    
    //****************************
    // Mark: CRUD CHO BANG BILL
    //****************************
    //1. Insert bill vao database
    public func insert(bill:Bill)->Bool {
        var ok = false
        //Cau lenh sql de insert du lieu vao database
        let sql = "INSERT INTO \(BILL_TABLE_NAME) ("
            + BILL_DATE + "," + BILL_DETAIL + "," + BILL_TOTAL + ")"
            + " VALUES (?, ?, ?)"
        //Thuc hien ca lenh SQL
        if open() {
            if database!.executeUpdate(sql, withArgumentsIn: [bill.getDate(), bill.getDetail(), bill.getTotal()]) {
                ok = true
                os_log("Them bill thanh cong")
                let _ = close()
            }
        }
        else {
            os_log("Khong ghi duoc du lieu")
        }
        return ok
        
    }
    //2. delete bill vao database
    public func delete(_id:Int)->Bool {
        var ok = false
        //Cau lenh sql de insert du lieu vao database
        let sql = "DELETE FROM \(BILL_TABLE_NAME) WHERE \(BILL_ID) LIKE \(_id) "
        //Thuc hien ca lenh SQL
        if open() {
            if database!.executeUpdate(sql, withArgumentsIn: [_id]) {
                ok = true
                os_log("Xoa bill thanh cong")
                let _ = close()
            }
        }
        else {
            os_log("Khong ghi duoc du lieu")
        }
        return ok
        
    }
    //3. edit bill vao database
    public func edit(_bill:Bill)->Bool {
        var ok = false
        //Cau lenh sql de insert du lieu vao database
        let sql = "UPDATE FROM \(BILL_TABLE_NAME) SET \(BILL_DATE) = \(_bill.getDate()), \(BILL_DETAIL) = \(String(describing: _bill.getDetail)), \(BILL_TOTAL) = \(_bill.getTotal()) WHERE \(BILL_ID) LIKE \(_bill.getId()) "
        
        //Thuc hien ca lenh SQL
        if open() {
            if database!.executeUpdate(sql, withArgumentsIn: [_bill.getId()]) {
                ok = true
                os_log("Xoa bill thanh cong")
                let _ = close()
            }
        }
        else {
            os_log("Khong ghi duoc du lieu")
        }
        return ok
        
    }
    //Doc toan bo cac mon an tu database
    public func getAllBill(bills: inout [Bill]) {
        //Cau lenh sql
        let sql = "SELECT * FROM \(BILL_TABLE_NAME) ORDER BY \(BILL_DATE) DESC"
        //Thuc hien doc du lieu
        if open() {
            var result:FMResultSet?
            do {
                result = try database!.executeQuery(sql, values: nil)
            }
            catch {
                os_log("Loi khi do du lieu tu database")
            }
            //Xu li ket qua doc duoc
            if let result = result {
                while (result.next()) {
                    let id = result.int(forColumn: BILL_ID)
                    let date = result.string(forColumn: BILL_DATE) ?? ""
                    let detail = result.string(forColumn: BILL_DETAIL) ?? ""
                    let total = result.int(forColumn: BILL_TOTAL)
                    //Tao bien meal doc duoc
                    if let bill = Bill(id: Int(id),date: date, detail: String(detail), total: Int(total)) {
                        //luu vao mang tham bien
                        bills.append(bill)
                    }
                }
            }
            let _ = close()
            
        }
    }
    //****************************
    // Mark: CRUD CHO BANG TABLE
    //****************************
    
    public func getAllTable(_tables: inout [Table]){
        //thuc hien doc du lieu
        if (open()){
            let sql = "SELECT * FROM \(TABLE_TABLE_NAME)"
            var result:FMResultSet?
            // Xu ly ngoai le
            do{
                result = try database!.executeQuery(sql, values: nil)
            }
            catch{
                os_log("Error when trying to read table: table form database")
            }
            //Xu ly ket qua dat duoc
            if let result = result {
                while (result.next()){
                    let name = result.string(forColumn: TABLE_NAME) ?? ""
                    
                    //tao bien order da doc duoc
                    if let table = Table(name: name){
                        //luu vao mang tham bien
                        _tables.append(table)
                    }
                }
            }
            let _ = close()
        }
    }
    
    public func deleteTable(_table: Table){
        if open(){
             let sql = "DELETE FROM \(TABLE_TABLE_NAME) WHERE \(TABLE_NAME) = \(_table.getName())"
            do {
                // Thực hiện câu lệnh SQL
                try database?.executeUpdate(sql, values: nil)
            } catch {
                print("Error when trying to delete order: \(error.localizedDescription)")
            }
        }
        let _ = close()
    }
    func updateTable(_table:Table, newName:String) {
        // Mở kết nối với cơ sở dữ liệu
        if open() {
            // Lặp qua mảng các đối tượng Order
            
                let sql = "UPDATE \(TABLE_TABLE_NAME) SET \(TABLE_NAME) = \(newName) WHERE \(TABLE_NAME) = \(_table.getName())"
                
                // Xử lý ngoại lệ
                do {
                    // Thực hiện câu lệnh SQL
                    try database?.executeUpdate(sql, values: nil)
                } catch {
                    print("Error when trying to update order: \(error.localizedDescription)")
                }
            
            
            // Đóng kết nối với cơ sở dữ liệu
            let _ = close()
        }
    }
    
    
    //********************************************************************
    //Dinh nghia cac ham API bang Dish
    //********************************************************************
    //1. Insert dish vao database
    public func insertDish(dish:Dish)->Bool {
        var ok = false
        //Chuyen anh thanh Text truoc khi luu vao co so du lieu
        var strImage = ""
        if let image = dish.getImage() {
            let nsDataImage = image.pngData()! as NSData
            strImage = nsDataImage.base64EncodedString(options: .lineLength64Characters)
        }
        //Cau lenh sql de insert du lieu vao database
        let sql = "INSERT INTO \(DISH_TABLE_NAME) ("
            + DISH_NAME + "," + DISH_PRICE + "," + DISH_IMAGE + ")"
            + " VALUES (?, ?, ?)"
        //Thuc hien ca lenh SQL
        if open() {
            if database!.executeUpdate(sql, withArgumentsIn: [dish.getName(), dish.getPrice(), strImage]) {
                ok = true
                os_log("Them mon an thanh cong")
                let _ = close()
            }
        }
        else {
            os_log("Khong ghi duoc du lieu")
        }
        return ok
        
    }
    //2. Doc toan bo cac mon an tu database
    public func getAllDish(dishes: inout [Dish]) {
        //Cau lenh sql
        
        //Thuc hien doc du lieu
        if open() {
            let sql = "SELECT * FROM \(DISH_TABLE_NAME) ORDER BY \(DISH_PRICE) DESC"
            var result:FMResultSet?
            do {
                result = try database!.executeQuery(sql, values: nil)
            }
            catch {
                os_log("Loi khi do du lieu tu database")
            }
            //Xu li ket qua doc duoc
            if let result = result {
                while (result.next()) {
                    let name = result.string(forColumn: DISH_NAME) ?? ""
                    let price = result.long(forColumn: DISH_PRICE)
                    var image:UIImage? = nil
                    let strImage = result.string(forColumn: DISH_IMAGE) ?? ""
                    if !strImage.isEmpty {
                        //Chuyen chuoi thanh anh
                        let dataImage = Data(base64Encoded: strImage, options: .ignoreUnknownCharacters)
                        image = UIImage(data: dataImage!)
                    }
                    //Tao bien meal doc duoc
                    if let dish = Dish(name: name, price: Int(price), image: image){
                        //luu vao mang tham bien
                        dishes.append(dish)
                    }
                }
            }
            let _ = close()
            
        }
    }
    //3. delete bill vao database
    public func deleteDish(dish:Dish)->Bool {
        var ok = false
        //Cau lenh sql de insert du lieu vao database
        
        //Thuc hien ca lenh SQL
        if open() {
            let sql = "DELETE FROM \(DISH_TABLE_NAME) WHERE \(DISH_NAME) = ? AND \(DISH_PRICE) = ? "
            if database!.executeUpdate(sql, withArgumentsIn: [dish.getName(), dish.getPrice()]) {
                ok = true
                os_log("Xoa mon an thanh cong")
                let _ = close()
            }
        }
        else {
            os_log("Khong ghi duoc du lieu")
        }
        return ok
        
    }
    //4. edit bill vao database
    public func edit(oldDish:Dish, newDish:Dish)->Bool {
        var ok = false
        //Cau lenh sql de insert du lieu vao database
       
        //Thuc hien ca lenh SQL
        // Chuyen doi du lieu tu dang image sang dang string
        let newImageData: NSData = newDish.getImage()!.pngData()! as NSData
        let newStringImage = newImageData.base64EncodedString(options:.lineLength64Characters)
        if open() {
            let sql = "UPDATE FROM \(DISH_TABLE_NAME) SET \(DISH_NAME) = ?, \(DISH_PRICE) = ?, \(DISH_IMAGE) = ? WHERE \(DISH_NAME) = ? AND \(DISH_PRICE) = ?  "
            if database!.executeUpdate(sql, withArgumentsIn: [newDish.getName(),newDish.getPrice(),newStringImage,oldDish.getName(),oldDish.getPrice()]) {
                ok = true
                os_log("Sua mon an thanh cong")
                let _ = close()
            }
        }
        else {
            os_log("Khong ghi duoc du lieu")
        }
        return ok
        
    }
}

