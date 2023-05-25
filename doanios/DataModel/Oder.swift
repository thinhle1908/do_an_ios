//
//  Oder.swift
//  doanios
//
//  Created by Minh on 5/24/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//
import UIKit
import Foundation

class Order {
    //MARK: Properties
    
    private var name:String
    private var table:String
    private var state:String
    private var quantity:Int
    private var price:Int
    //Contructors
    init?(name:String,table:String,state:String,quantity:Int,price:Int) {
        if name.isEmpty {
            return nil
        }
        if quantity < 0 || quantity == 0 {
            return nil
        }
        
        self.name = name
        self.table = table
        self.state = state
        self.quantity = quantity
        self.price = price
    }
    
    public func getName() -> String {
        return name
    }
    
    public func setName(_ newName: String) {
        name = newName
    }
    
    public func getTable() -> String {
        return table
    }
    
    public func setTable(_ newTable: String) {
        table = newTable
    }
    
    public func getState() -> String {
        return state
    }
    
    public func setState(_ newState: String) {
        state = newState
    }
    
    public func getQuantity() -> Int {
        return quantity
    }
    
    public func setQuantity(_ newQuantity: Int) {
        quantity = newQuantity
    }
    
    public func getPrice() -> Int {
        return price
    }
    
    public func setPrice(_ newPrice: Int) {
        price = newPrice
    }
 }
