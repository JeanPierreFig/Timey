//
//  ViewController.swift
//  Timey
//
//  Created by Jean Pierre on 1/9/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit
import CoreData
import AASegmentedControl
import AVKit
import AVFoundation

public let IMAGE_CELL = "Image_cell"
public let CoreData_Entity_Name = "Timelapse"
public let SELECTED_SEGUE = "selectedCell"

class ViewController: UIViewController{
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var manageContext:NSManagedObjectContext!
    private var entityDescription: NSEntityDescription!
    private var collectionData: [Content] = []
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
       // collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)
        manageContext = appDelegate.managedObjectContext
        entityDescription = NSEntityDescription.entity(forEntityName: CoreData_Entity_Name, in: manageContext)
        
        //Retrive data from core data
        collectionData = CoreDataHelper.LoadData(manageContext: manageContext)
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ImageCollectionViewController {
            let cell = sender as! UICollectionViewCell
            let indexPath = collectionView.indexPath(for: cell)
            dest.contentItem  = collectionData[(indexPath?.row)!]
            dest.isSaved = true
        }
    }
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IMAGE_CELL, for: indexPath) as? ImageCollectionViewCell
        cell?.photo = collectionData[indexPath.row].firstImage
        cell?.title = collectionData[indexPath.row].title
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: SELECTED_SEGUE, sender: collectionView.cellForItem(at: indexPath))
    }
}

extension ViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 250
        }
        return 300
    }
}

