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
    
    @IBOutlet weak var dishImage: UIImageView!
    
    @IBOutlet weak var txtDishName: UITextField!
    
    @IBOutlet weak var txtPrice: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Them vien duoi cho textfield
        underLineTextField(tf: txtDishName)
        underLineTextField(tf: txtPrice)
        
        txtDishName.delegate = self
        
        // Do any additional setup after loading the view.
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
    @IBAction func back(_ sender: Any) {
        print("Tro ve")
        
    }
    
    @IBAction func addDish(_ sender: Any) {
        print("Da them mon")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        txtDishName.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Name of the Food is \(txtDishName.text)")
    }
    //Ham them gachs duoi
    func underLineTextField(tf:UITextField!) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 30, width: view.frame.width-40, height: 1.0)
        
        bottomLine.backgroundColor = UIColor.black.cgColor
        tf.layer.addSublayer(bottomLine)
        
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
