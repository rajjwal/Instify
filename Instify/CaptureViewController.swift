//
//  CaptureViewController.swift
//  Instify
//
//  Created by Rajjwal Rawal on 3/20/17.
//  Copyright © 2017 Rajjwal Rawal. All rights reserved.
//

import UIKit
import PKHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagepicker = UIImagePickerController()
    
    @IBOutlet weak var imageSelectionView: UIView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var captureLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PKHUD.sharedHUD.contentView = PKHUDSuccessView()
        
        
        imagepicker.delegate = self
        selectedImageView.image = nil
        captureLabel.text = nil
        
    }
    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        // let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.image = editedImage
        imageSelectionView.backgroundColor = .clear
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagepicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPostButtonPressed(_ sender: Any) {
        
        HUD.show(.progress)
        
        Post.postUserImage(image: selectedImageView.image,
                           withCaption: captureLabel.text,
                           withCompletion: { _ in
                            DispatchQueue.main.async {
                                self.selectedImageView.image = nil
                                self.captureLabel.text = nil
                                HUD.flash(.success)
                            }}
        )
    }
    
    
    @IBAction func onAddButtonPressed(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        present(vc, animated: true, completion: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
