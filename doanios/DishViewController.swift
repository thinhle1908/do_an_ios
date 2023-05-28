//
//  DishViewController.swift
//  doanios
//
//  Created by CNTT on 5/25/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class DishViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Properties
    var dish: Dish?
    @IBOutlet weak var dishImage: UIImageView!
    
    @IBOutlet weak var txtDishName: UITextField!
    
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var btnThemMon: UIButton!
    //dinh nghia bien enum cho duong di cua man hinh
    enum navigationType {
        case adddish
        case editdish
    }
    var navigationtype:navigationType = .adddish
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Them vien duoi cho textfield
        underLineTextField(tf: txtDishName)
        underLineTextField(tf: txtPrice)
        
        txtDishName.delegate = self
        btnThemMon.setTitle("them mon", for: .normal)
        
        // Do any additional setup after loading the view.
        //Lay du lieu tu dish neu co
        if let dish  = dish{
            navigationItem.title = dish.getName()
            txtDishName.text = dish.getName()
            //dua anh cua mon an vao imgview
            txtPrice.text = String(dish.getPrice())
            //dua ratingvalue vao ratingcontroll
            dishImage.image = dish.getImage()
            btnThemMon.setTitle("sua mon", for: .normal)
        }
        updateSavestate()
    }
    
    
    @IBAction func pickUpImage(_ sender: UITapGestureRecognizer) {
        //print("Image pickup")
        //1. An ban phim
        txtDishName.resignFirstResponder()
        txtPrice.resignFirstResponder()
        let imagePicker = UIImagePickerController()
        //Cau hinh cho doi tuong image picker
        imagePicker.sourceType = .photoLibrary
        //B3: Thuc hien uy quyen cho doi tuongw imagePicker
        imagePicker.delegate = self
        // Hien thi man hinh cua image picker
        present(imagePicker, animated: true, completion: nil)
    }
    // Dinh nghia cac ham uy quyen cho doi tuong image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //image selected processing
        if let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            //Dua image selected vao image view cua mon an
            dishImage.image = imageSelected
        }
        //An man hinh hien tai, quay ve ,am hinh truoc do
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addDish(_ sender: Any) {
        print("Da them mon")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        txtDishName.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("Name of the Food is \(txtDishName.text)")
        navigationItem.title = txtDishName.text
        updateSavestate()
    }
    //Ham them gachs duoi
    func underLineTextField(tf:UITextField!) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 30, width: view.frame.width-40, height: 1.0)
        
        bottomLine.backgroundColor = UIColor.black.cgColor
        tf.layer.addSublayer(bottomLine)
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        switch  navigationtype {
        case .adddish:
            dismiss(animated: true, completion: nil)
        case .editdish:
            if let navigtionController = navigationController{
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Kiem tra nut them mon duoc nhan hay chua
        if let button = sender as? UIButton, button === btnThemMon{
            let name = txtDishName.text ?? ""
            let price = txtPrice.text ?? ""
            let image = dishImage.image
            dish = Dish(name: name, price: Int(price)!, image: image)
        }
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
    private func updateSavestate(){
        let name = txtDishName.text ?? ""
        let price = txtPrice.text ?? ""
        let image = dishImage.image
     
        if(!name.isEmpty && !price.isEmpty && image != nil){
            btnThemMon.backgroundColor = UIColor.green
            btnThemMon.isEnabled = true
        }
        else{
            btnThemMon.backgroundColor = UIColor.gray
            btnThemMon.isEnabled = false
        }
    }
    
}
