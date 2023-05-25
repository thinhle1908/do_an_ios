//
//  Bill.swift
//  doanios
//
//  Created by Minh on 5/24/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import Foundation
import UIKit

class Bill{
    private var id:Int
    private var date:String
    private var detail:String
    private var total: Int
    
    
    init?(id:Int, date: String, detail: String, total: Int) {
        self.id = id
        self.date = date
        self.detail = detail
        self.total = total
        
    }
    
    public func getId() -> Int {
        return id
    }
    
    public func setId(_ newId: Int) {
        id = newId
    }
    
    public func getDate() -> String {
        return date
    }
    
    public func setDate(_ newDate: String) {
        date = newDate
    }
    
    public func getDetail() -> String {
        return detail
    }
    
    public func setDetail(_ newDetail: String) {
        detail = newDetail
    }
    
    public func getTotal() -> Int {
        return total
    }
    
    public func setTotal(_ newTotal: Int) {
        total = newTotal
    }
}

