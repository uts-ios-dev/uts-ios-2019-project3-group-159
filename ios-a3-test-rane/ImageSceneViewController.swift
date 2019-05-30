//
//  ImageSceneViewController.swift
//  ios-a3-test-rane
//
//  Created by Lahiru Ranasinghe on 29/5/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

import UIKit

class ImageSceneViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var editImageView: UIImageView!
    
    @IBAction func photoBtn(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image,animated: true){
            //after its complete
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            editImageView.image = image
           
            //            let img = UIImage(
            let imageView = DIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            view = imageView
        }else{
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
