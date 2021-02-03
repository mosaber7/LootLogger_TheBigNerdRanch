//
//  DetailsViewController.swift
//  LootLogger
//
//  Created by Saber on 28/01/2021.
//

import UIKit

class DetailViewControllers: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item!{
        didSet{
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    let dateFormater : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollar))
        dateLabel.text = dateFormater.string(from:item.dateCreated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollar = value.intValue
        }
        else{
            item.valueInDollar = 0
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType)-> UIImagePickerController{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        
        let alertcontroller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertcontroller.modalPresentationStyle = .popover
        alertcontroller.popoverPresentationController?.barButtonItem = sender
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        alertcontroller.addAction(cameraAction)
        
        let photoAction = UIAlertAction(title: "Photo", style: .default){ _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertcontroller.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertcontroller.addAction(cancelAction)
        
        present(alertcontroller, animated: true, completion: nil)
    }
    
    
    
}
