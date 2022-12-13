//
//  addPhotoViewController.swift
//  FotografListesi
//
//  Created by Muhammed Gül on 16.11.2022.
//

import UIKit
import CoreData

class addPhotoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var selectedItem : Entity? = nil
    
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtDescription: UITextField!
    
    @IBOutlet weak var imgPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedItem == nil {
            // yeni bir fotograf eklenecek
            self.navigationItem.title = "Add a new photo"
        } else {
            // var olan bir fotograf düzenlenecek
            self.navigationItem.title = selectedItem?.titleText
            txtTitle.text = selectedItem?.titleText
            txtDescription.text = selectedItem?.titleText
            imgPhoto.image = UIImage(data: (selectedItem?.image as! Data))
            btnSave.setTitle("Update", for: UIControl.State.normal)
        }

     
    }
    @IBAction func btnCameraClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selecetedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgPhoto.image = selecetedImage
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnGaleryClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        if selectedItem == nil {
            let entityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: pc)
            let newItem = Entity(entity: entityDescription!, insertInto: pc)
            newItem.titleText = txtTitle.text
            newItem.titleText = txtDescription.text
            newItem.image = imgPhoto.image!.jpegData(compressionQuality: 0.8) as NSData?
        } else {
            selectedItem?.titleText = txtTitle.text
            selectedItem?.descriptionText = txtDescription.text
            selectedItem?.image = imgPhoto.image!.jpegData(compressionQuality: 0.8) as NSData? 
        }
        
       
        do {
            
            if pc.hasChanges{
                try pc.save()
            }
        } catch {
            print(error)
            return
        }
        navigationController!.popViewController(animated: true)
    }
    
    
    
    @IBAction func dismisKeyboard(_ sender: UITextField) {
        self.resignFirstResponder()
    }
    
}
