//
//  CreateTimeLapseViewController.swift
//  Timey
//
//  Created by Jean Pierre on 1/12/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit
import AASegmentedControl
import CoreData
//
//protocol  CreateTimeLapseDelegate{
//    /** Tells when a user has created a new time-lapse.*/
//    func didCreateNewTimeLapse()
//}
//
//class CreateTimeLapseViewController: UIViewController,UITextFieldDelegate {
//    private  let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    private var manageContext:NSManagedObjectContext!
//    private var entityDescription: NSEntityDescription!
//    private var HighScoreObject:NSManagedObject!
//
//    @IBOutlet var segmentedControl: AASegmentedControl!
//    @IBOutlet var createButton: UIButton!
//    @IBOutlet var inputField: UITextField!
//    @IBOutlet var DataPicker: UIDatePicker!
//    @IBOutlet var previewImageView: UIImageView!
//    var imagesTaken = [UIImage]()
//    var delegate:CreateTimeLapseDelegate!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        manageContext = appDelegate.managedObjectContext
//        entityDescription = NSEntityDescription.entity(forEntityName: "Timelapse", in: manageContext)
//        
//        segmentedControl.itemNames = ["day at", "Min", "no notification"]
//        segmentedControl.font = UIFont(name: "Helvetica Neue", size: 12.0)!
//        segmentedControl.selectedIndex = 2
//        segmentedControl.addTarget(self,
//                                   action: #selector(ViewController.segmentValueChanged(_:)),
//                                   for: .valueChanged)
//        DataPicker.setValue(UIColor.white, forKeyPath: "textColor")
//        DataPicker.isEnabled = false
//        createButton.layer.masksToBounds = true
//        createButton.layer.cornerRadius = 15
//        createButton.layer.borderWidth = 1
//        createButton.layer.borderColor = UIColor.white.cgColor
//        inputField.delegate = self
//        
//        previewImageView.animationImages = imagesTaken
//        previewImageView.animationDuration = Double(imagesTaken.count)*0.1
//        previewImageView.startAnimating()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func datePickerChanged(sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        
//        if segmentedControl.selectedIndex == 0{
//          dateFormatter.dateFormat = ""
//        }
//        
//        dateFormatter.dateFormat = "MMM dd, YYYY"
//        let somedateString = dateFormatter.string(from: sender.date)
//        
//        print(somedateString)  // "somedateString" is your string date
//    }
//
//    
//    @IBAction func create(_ sender: Any){
//        saveToCoreData()
//       self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
//
//    }
//    
//    func saveToCoreData(){
//        let object = NSManagedObject(entity:entityDescription,insertInto: manageContext)
//        object.setValue(inputField.text, forKeyPath: "title")
//        object.setValue(saveToDisk(), forKey: "imagesPath")
//        object.setValue(Date(), forKeyPath: "createdAt")
//        appDelegate.saveContext()
//    }
//    
//    /** save all images taken to disk and generate an array of image path.*/
//    func saveToDisk() -> [String]{
//        var imagesPath = [String]()
//        
//        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//    
//            for image in imagesTaken{
//                
//                let fileName = String.uniqueFilename()+".jpg"
//                let fileURL = dir.appendingPathComponent(fileName)
//                print(fileName)
//                
//                do {
//                    try UIImageJPEGRepresentation(removeRotationForImage(image: image), 1)?.write(to: fileURL, options: .atomic)
//                    imagesPath.append(fileName)
//                }
//                catch {
//                    print("error: Saving the image to disk.")
//                }
//            }
//        }
//        
//        return imagesPath
//    }
//    
//    func removeRotationForImage(image: UIImage) -> UIImage {
//        if image.imageOrientation == UIImageOrientation.up {
//            return image
//        }
//
//        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
//        image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: image.size))
//        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return normalizedImage
//    }
//    
//    
//    @IBAction func Dissmis(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @objc func segmentValueChanged(_ sender: AASegmentedControl) {
//        segmentedControl.reloadInputViews()
//        switch sender.selectedIndex {
//        case 0:
//            DataPicker.isEnabled = true
//            DataPicker.datePickerMode = UIDatePickerMode.time
//        case 1:
//            DataPicker.isEnabled = true
//            DataPicker.datePickerMode = UIDatePickerMode.countDownTimer
//        case 2:
//            DataPicker.isEnabled = false
//        default:
//            print("segment error")
//        }
//    }
//    
//    //MARK: UITextFieldDelegate
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
//}
