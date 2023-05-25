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
    private var name:String
    
    init?(name:String){
        self.name = name
    }
    
    public func getName() -> String {
        return name
    }
    
    public func setName(_ newValue: String) {
        name = newValue
    }
    
    
}
