//
//  ImageCollectionViewController.swift
//  Timey
//
//  Created by Jean Pierre on 1/15/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Photos
import TwitterKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseStorage
import ImageIO
import MobileCoreServices

class ImageCollectionViewController: UIViewController {
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var postButton:UIButton!
    @IBOutlet var imagesCountLable: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var PreviewImageView: UIImageView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var instagram: UIButton!
    @IBOutlet var saveForLater: UIButton!
    @IBOutlet var saveToCameraRoll: UIButton!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var manageContext:NSManagedObjectContext!
    var contentItem: Content!
    var longPressGesture: UIGestureRecognizer!
    var VideoURL: URL!
    var isSaved: Bool!
    var didUpadeDataSource = false
    var imagesTaken = [UIImage]()
    var PreviewImages = [UIImage]()
    var dataSource  = [UIImage]()
    
    enum shareAction : Int {
        case instagram = 0
        case saveForLater = 1
        case saveToCameraRoll = 2
    }
    
    //Do not show the status bar.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        manageContext = appDelegate.managedObjectContext
        
        //Draw camera button on screen.
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = cameraButton.frame.width/2
        cameraButton.layer.borderWidth = 6
        cameraButton.layer.borderColor = (UIColor.white).cgColor
        postButton.layer.masksToBounds = true
        postButton.layer.cornerRadius = 15
        postButton.layer.backgroundColor = UIColor.white.cgColor
    
        //Is is a data source 
        if isSaved {
            dataSource = CoreDataHelper.RetrieveImagesFromDisk(imageNames:contentItem.imagesPath)
        }
        else {
            dataSource = imagesTaken
        }
        setUpPreview()
    }

    func setUpPreview() {
        //Start animating the background with the images taken.
        PreviewImageView.stopAnimating()
        PreviewImageView.animationImages = dataSource
        PreviewImageView.animationDuration = Double(dataSource.count)*0.1
        PreviewImageView.startAnimating()
        //generate a number icon with the amount of image in the collection.
        imagesCountLable.text = dataSource.count.description
        imagesCountLable.layer.masksToBounds = true
        imagesCountLable.layer.cornerRadius = 12
        imagesCountLable.layer.backgroundColor = UIColor.white.cgColor
        imagesCountLable.layer.opacity = 0.9
        //Give the tiny cells the image then add a loop logo/icon at the front of the collection.
        PreviewImages = dataSource
        PreviewImages.insert(#imageLiteral(resourceName: "time-lapse"), at: 0)
        collectionView.reloadData()
    }
    
    func setUpShareView() {
        blurView.isHidden = false
        //Intagram button
        instagram.layer.backgroundColor = UIColor(red: 229/255, green: 105/255, blue: 105/255, alpha: 1).cgColor
        instagram.layer.cornerRadius = 15
        //Save for later button
        saveForLater.layer.backgroundColor = UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 1).cgColor
        saveForLater.layer.cornerRadius = 15
        //Save to camera Roll
        saveToCameraRoll.layer.backgroundColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1).cgColor
        saveToCameraRoll.layer.cornerRadius = 15
        
        if isSaved == true{
            saveForLater.isEnabled = false
            saveForLater.setTitle("Already saved", for: .normal)
        }
    }
    
    @IBAction func shareActionButton(_ sender: UIButton){
        
        if let video = VideoURL{
            
            switch shareAction.init(rawValue: sender.tag)! {
                
            case .instagram:
                //This line will create the video, save it to the camera roll and open instagram to allow the user to post the video
                //Note add error handaling if the user does not have the instagram app on the phone
                ShareHelper.ToCameraRoll(fileURL: video, completion: { (fileURL:String) in
                    UIApplication.shared.open(URL(string:"instagram://library?LocalIdentifier=\(fileURL)")!, options: [:] , completionHandler: nil)
                })
                
            case .saveForLater:
                performSegue(withIdentifier: "SaveSegue", sender: nil)
                
            case .saveToCameraRoll:
                ShareHelper.ToCameraRoll(fileURL: video, completion: { (url:String) in
                    //on Complete how alert.
                    self.popupAlert(title: "Saved!", message: "The video in located in your camera roll.", actionTitles: ["Ok"], actions: [nil])
                    })
            default:
                print("Some other thing is calling the post fuction ")
            }
        }
        
    }
    
    @IBAction func sendTo() {
        //Generate the video from the images and set up the share screen
        setUpShareView()
        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecType.h264.rawValue, width: (dataSource[1].cgImage?.width)!, height: (dataSource[1].cgImage?.height)!)
        let movieMaker = CXEImagesToVideo(videoSettings: settings, frameTime:CMTimeMake(1, 7))
        movieMaker.createMovieFrom(images: dataSource){ (fileURL:URL) in
            self.VideoURL = fileURL
        }
    }
    
    //Make sure the user saved any updates.
    @IBAction func dismiss(){
        if didUpadeDataSource {
            self.popupAlert(title: "Save", message: "You added new images that are not saved. Do you want to save them?", actionTitles: ["Save","Delete"], actions:[
                { action1 in
                    //Save update.
                    CoreDataHelper.updateData(contentItem: self.contentItem, manageContext: self.manageContext, completion: {
                            self.dismiss(animated: true, completion: nil)
                    })
                },
                {action2 in
                      self.dismiss(animated: true, completion: nil)
                }])
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func dismissShareView() {
        blurView.isHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CameraViewController{
            dest.isSaved = true
            dest.delegate = self
        }
        if let dest = segue.destination  as? CreateTimeLapseViewController{
            self.dataSource.remove(at: 0)
            dest.imagesTaken = self.dataSource
        }
    }
}

extension ImageCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PreviewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath as IndexPath) as! TinyCollectionViewCell
        
        if indexPath.row != 0 {
            cell.setupView()
        }
        
        cell.photo = PreviewImages[indexPath.row]
        return cell
    }
    
}

///This is used for the collection view cell.
extension ImageCollectionViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellIndex = self.collectionView.indexPathForItem(at: CGPoint(x: collectionView.frame.width/2 + scrollView.contentOffset.x, y: collectionView.frame.height/2 + scrollView.contentOffset.y))
        PreviewImageView.stopAnimating()
        
        if let index = cellIndex?.row{
            if index == 0{
                PreviewImageView.startAnimating()
            }
            else{
                PreviewImageView.image = dataSource[index-1]
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToNearestCell(scrollView as! UICollectionView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToNearestCell(scrollView as! UICollectionView)
    }
    
    func snapToNearestCell(_ collectionView: UICollectionView) {
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let itemWithSpaceWidth =  layout.itemSize.width + layout.minimumLineSpacing
            let itemWidth = layout.itemSize.width
            
            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
                
                let indexPath = IndexPath(item: i, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }
}

extension ImageCollectionViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension ImageCollectionViewController: cameraProtocal{
    //Recive the images added to the time-lapse it's still not saved.
    func didAddMoreImages(images:[UIImage]) {
        dataSource += images
        if images.count != 0{
            didUpadeDataSource = true
            setUpPreview()
        }
    }
}

