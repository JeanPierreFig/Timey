//
//  ImageCollectionViewController.swift
//  Timey
//
//  Created by Jean Pierre on 1/15/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UIViewController {
    @IBOutlet var cameraButton: UIButton!
    var inProgress: inprogress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Draw camera button on screen.
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = cameraButton.frame.width/2
        cameraButton.layer.borderWidth = 10
        cameraButton.layer.borderColor = (UIColor.white).cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(){
        self.dismiss(animated: true, completion: nil)
    }
    


}
