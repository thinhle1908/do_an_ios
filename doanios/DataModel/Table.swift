//
//  table.swift
//  doanios
//
//  Created by Minh on 5/24/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//
import UIKit
import Foundation

class Table {
    var id:String
    private var name:String
    
    init?(id:String, name:String){
        self.id = id
        self.name = name
    }
    
    public func getName() -> String {
        return name
    }
    
    public func setName(_ newValue: String) {
        name = newValue
    }
    public func getID() -> String {
        return id
    }
    
}
