//
//  Dish.swift
//  doanios
//
//  Created by Minh on 5/24/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//
	
import UIKit
class Dish{
    private var name:String
    private var price:Int
    private var image:UIImage?
    
    init?(name: String, price: Int, image: UIImage?) {
        self.name = name
        self.price = price
        self.image = image
    }
    
    // Getter cho thuộc tính name
    public func getName() -> String {
        return name
    }
    
    // Setter cho thuộc tính name
    public func setName(_ newName: String) {
        name = newName
    }
    
    // Getter cho thuộc tính price
    public func getPrice() -> Int {
        return price
    }
    
    // Setter cho thuộc tính price
    public func setPrice(_ newPrice: Int) {
        price = newPrice
    }
    
    // Getter cho thuộc tính image
    public func getImage() -> UIImage? {
        return image
    }
    
    // Setter cho thuộc tính image
    public func setImage(_ newImage: UIImage?) {
        image = newImage
    }
}

