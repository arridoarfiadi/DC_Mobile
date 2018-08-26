//
//  ViewController.swift
//  DiversityCenterAdmin
//
//  Created by Arrido Arfiadi on 8/25/18.
//  Copyright © 2018 Arrido Arfiadi. All rights reserved.
//

import UIKit
import Vision
import CoreML
import Firebase
import SVProgressHUD

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var itemLabel: UITextField!
    @IBOutlet weak var imageFrame: UIImageView!
    @IBOutlet weak var amountLabel: UITextField!
    
    var ref: DatabaseReference = Database.database().reference()
    let imagePicker = UIImagePickerController()
    var choiceArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
    }

    func addAlert() {
        let alert = UIAlertController(title: "Item Recognize", message: "Choose the desired item", preferredStyle: .actionSheet)
        for i in 0..<choiceArray.count{
            alert.addAction(UIAlertAction(title: choiceArray[i], style: .default, handler: { (alertAction) in
                self.itemLabel.text = self.choiceArray[i]
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let chosenPhoto = info[UIImagePickerControllerEditedImage] as? UIImage{
            guard let ciimage = CIImage(image: chosenPhoto) else {fatalError("CIImage Conversion error")}
            imageFrame.image = chosenPhoto
            detectImage(image: ciimage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
        addAlert()
        
    }
    
    func detectImage(image: CIImage){
        //VNCoreMLModel acts as a wrapper to the model we are using which is FlowerClassifier
        //Vision allows us to process image
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {fatalError("Loading ML Model error")}
        
        //make new request
        //when completed it will get a request and errror
        let request = VNCoreMLRequest(model: model) { (request, error) in
            //stores the results
            guard let results = request.results as? [VNClassificationObservation] else {fatalError("result loading error")}
            //results gives you how accurate it think the picture was to a certain thing
            for i in 0..<4{
                self.choiceArray.append(results[i].identifier)
            }
        }
        //handles the request
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    @IBAction func insertPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        itemLabel.endEditing(true)
        amountLabel.endEditing(true)
        itemLabel.isEnabled = false
        amountLabel.isEnabled = false
        sendButton.isEnabled = false
        let pantryDB = ref.child("DCPantry").child(itemLabel.text!)
        //let itemDictionary: [String:String] =  [itemLabel.text!: ]
        pantryDB.setValue(amountLabel.text!){
            (error,reference) in
            if error != nil {
                print(error!)
            }
            else {
                print("message saved")
                self.itemLabel.isEnabled = true
                self.amountLabel.isEnabled = true
                self.sendButton.isEnabled = true
                self.itemLabel.text = ""
                self.amountLabel.text = ""
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Saved", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
                self.present(alert,animated: true,completion: nil)
            }
        }

        
       
        
    }
    
}

