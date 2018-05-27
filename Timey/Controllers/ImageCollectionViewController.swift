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
//
//class ImageCollectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
//    @IBOutlet var cameraButton: UIButton!
//    @IBOutlet var postButton:UIButton!
//    @IBOutlet var imagesCountLable: UILabel!
//    @IBOutlet var collectionView: UICollectionView!
//    @IBOutlet var PreviewImageView: UIImageView!
//    @IBOutlet var blurView: UIVisualEffectView!
//    @IBOutlet var twitterButton: UIButton!
//    @IBOutlet var instagram: UIButton!
//    @IBOutlet var saveForLater: UIButton!
//    @IBOutlet var postToTimey: UIButton!
//    private  let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    private var manageContext:NSManagedObjectContext!
//    private var entityDescription: NSEntityDescription!
//    private var HighScoreObject:NSManagedObject!
//
//    enum shareAction : Int {
//        case twitter = 0
//        case instagram = 1
//        case saveForLater = 2
//        case postToTimey = 3
//        case saveToCameraRoll = 4
//    }
//
//    @IBOutlet var saveToCameraRoll: UIButton!
//    var inProgressItem: InProgress!
//    var longPressGesture: UIGestureRecognizer!
//    var VideoURL: URL!
//    var isSaved: Bool!
//    var didUpadeDataSource = false
//    var imagesTaken = [UIImage]()
//    var imagesAdded = [UIImage]()
//    var PreviewImages = [UIImage]()
//    var dataSource  = [UIImage]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        manageContext = appDelegate.managedObjectContext
////        entityDescription = NSEntityDescription.entity(forEntityName: "Timelapse", in: manageContext)
////
////        longPressGesture = UILongPressGestureRecognizer(target: self, action:#selector(self.handleLongGesture(gesture:)))
////        self.collectionView.addGestureRecognizer(longPressGesture)
////
//////        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//////                loginButton.center = view.center
//////                self.view.addSubview(loginButton)
////
////        //Draw camera button on screen.
////        cameraButton.layer.masksToBounds = true
////        cameraButton.layer.cornerRadius = cameraButton.frame.width/2
////        cameraButton.layer.borderWidth = 6
////        cameraButton.layer.borderColor = (UIColor.white).cgColor
////
////        postButton.layer.masksToBounds = true
////        postButton.layer.cornerRadius = 15
////        postButton.layer.backgroundColor = UIColor.white.cgColor
////
////        setUpDataSource()
////        setUpPreview()
//
//    }
//
////    func setUpDataSource(){
////        if isSaved{
////            dataSource = getImagesFromDisk(imageNames: inProgressItem.imagesNames)
////        }
////        else{
////            dataSource = imagesTaken
////        }
////
////        PreviewImages = dataSource
////        PreviewImages.insert(#imageLiteral(resourceName: "time-lapse"), at: 0)
////    }
////
////    func setUpPreview(){
////        PreviewImageView.stopAnimating()
////        PreviewImageView.animationImages = dataSource
////        PreviewImageView.animationDuration = Double(dataSource.count)*0.1
////        PreviewImageView.startAnimating()
////
////        print(CMTimeMake(1, Int32(dataSource.count)))
////
////        imagesCountLable.text = dataSource.count.description
////        imagesCountLable.layer.masksToBounds = true
////        imagesCountLable.layer.cornerRadius = 12
////        imagesCountLable.layer.backgroundColor = UIColor.white.cgColor
////        imagesCountLable.layer.opacity = 0.9
////
////        PreviewImages = dataSource
////        PreviewImages.insert(#imageLiteral(resourceName: "time-lapse"), at: 0)
////        collectionView.reloadData()
////
////    }
////
////    func getImagesFromDisk(imageNames:[String]) -> [UIImage]{
////        var images = [UIImage]()
////        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////
////            for name in imageNames{
////                let fileURL = dir.appendingPathComponent(name)
////                do {
////                    let imageData = try Data(contentsOf: fileURL)
////                    images.append(UIImage(data: imageData)!)
////                }
////                catch{
////                    print("error: loading image data.")
////                }
////            }
////        }
////        return images
////    }
////
////    override func didReceiveMemoryWarning() {
////        super.didReceiveMemoryWarning()
////        // Dispose of any resources that can be recreated.
////    }
////
////    @IBAction func dismiss(){
////        if didUpadeDataSource == true{
////            let alert = UIAlertController(title: "Save", message: "You added new images that are not saved. Do you want to save them?", preferredStyle: UIAlertControllerStyle.alert)
////
////            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
////                self.dismiss(animated: true, completion: nil)
////            }))
////
////            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
////                if self.isSaved{
////                    self.updateSavedTimelapse(completion: {
////                        self.dismiss(animated: true, completion: nil)
////                    })
////                }
////                else{
////                    self.dismiss(animated: true, completion: nil)
////                }
////            }))
////            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
////            self.present(alert, animated: true, completion: nil)
////        }
////        else{
////            self.dismiss(animated: true, completion: nil)
////        }
////    }
////
////
////    func updateSavedTimelapse(completion: () -> ()){
////        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Timelapse")
////        let predicate = NSPredicate(format: "title == '\(inProgressItem.title)'")
////        fetchRequest.predicate = predicate
////        do
////        {
////            let test = try manageContext?.fetch(fetchRequest)
////
////            if test?.count == 1
////            {
////                print("got IT")
////                let allImagePath = inProgressItem.imagesNames + saveToDisk()
////                let objectUpdate = test![0]
////                 objectUpdate.setValue(allImagePath, forKey: "imagesPath")
////                do{
////                    try manageContext?.save()
////                    completion()
////                }
////                catch
////                {
////                    print(error)
////                }
////            }
////        }
////        catch
////        {
////            print(error)
////        }
////
////    }
////
////    func saveToDisk() -> [String]{
////        var imagesPath = [String]()
////
////        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////
////            for image in imagesAdded{
////
////                let fileName = String.uniqueFilename()+".jpg"
////                let fileURL = dir.appendingPathComponent(fileName)
////                print(fileName)
////
////                do {
////                    try UIImageJPEGRepresentation(removeRotationForImage(image: image), 1)?.write(to: fileURL, options: .atomic)
////                    imagesPath.append(fileName)
////                }
////                catch {
////                    print("error: Saving the image to disk.")
////                }
////            }
////        }
////
////        return imagesPath
////    }
////
////    func removeRotationForImage(image: UIImage) -> UIImage {
////        if image.imageOrientation == UIImageOrientation.up {
////            return image
////        }
////
////        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
////        image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: image.size))
////        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
////        UIGraphicsEndImageContext()
////        return normalizedImage
////    }
////
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return PreviewImages.count
////    }
////
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath as IndexPath) as! ImageCollectionViewCell
////        //this is really bad but it's the only way I could make it work for now.
////        cell.view.layer.borderWidth = 0
////        if indexPath.row != 0{
////            cell.view.layer.cornerRadius = 5
////            cell.view.layer.borderWidth = 2
////            cell.view.layer.borderColor = UIColor.white.cgColor
////            cell.view.clipsToBounds = true
////        }
////        cell.photo = PreviewImages[indexPath.row]
////        return cell
////    }
////
////    func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        let cellIndex = self.collectionView.indexPathForItem(at: CGPoint(x: collectionView.frame.width/2 + scrollView.contentOffset.x, y: collectionView.frame.height/2 + scrollView.contentOffset.y))
////
////        PreviewImageView.stopAnimating()
////        if let index = cellIndex?.row{
////            if index == 0{
////                PreviewImageView.startAnimating()
////            }
////            else{
////                PreviewImageView.image = dataSource[index-1]
////            }
////        }
////    }
////
////    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
////
////        snapToNearestCell(scrollView as! UICollectionView)
////    }
////    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
////
////        snapToNearestCell(scrollView as! UICollectionView)
////    }
////
////    func snapToNearestCell(_ collectionView: UICollectionView) {
////        for i in 0..<collectionView.numberOfItems(inSection: 0) {
////
////            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
////            let itemWithSpaceWidth =  layout.itemSize.width + layout.minimumLineSpacing
////            let itemWidth = layout.itemSize.width
////
////            if collectionView.contentOffset.x <= CGFloat(i) * itemWithSpaceWidth + itemWidth / 2 {
////                let indexPath = IndexPath(item: i, section: 0)
////                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
////                break
////            }
////        }
////    }
////
////    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
////
////        print(gesture.location(in: self.view))
////
////        switch(gesture.state) {
////
////        case UIGestureRecognizerState.began:
////            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
////                break
////            }
////            self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
////            break
////        case UIGestureRecognizerState.changed:
////
////            self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
////            break
////        case UIGestureRecognizerState.ended:
////            self.collectionView.endInteractiveMovement()
////            break
////        default:
////            self.collectionView.cancelInteractiveMovement()
////            break
////        }
////
////    }
////
////    func collectionView(_ collectionView: UICollectionView,
////                        moveItemAt sourceIndexPath: IndexPath,
////                        to destinationIndexPath: IndexPath) {
////        // move your data order
////    }
////
////    func setUpShareView(){
////        blurView.isHidden = false
////
////        twitterButton.setTitle("Twitter", for: UIControlState.normal)
////        twitterButton.layer.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1).cgColor
////        twitterButton.layer.cornerRadius = 15
////
////        instagram.layer.backgroundColor = UIColor(red: 229/255, green: 105/255, blue: 105/255, alpha: 1).cgColor
////        instagram.layer.cornerRadius = 15
////
////        if isSaved == true{
////            saveForLater.isEnabled = false
////            saveForLater.setTitle("Already saved", for: .normal)
////        }
////        saveForLater.layer.backgroundColor = UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 1).cgColor
////        saveForLater.layer.cornerRadius = 15
////
////        postToTimey.layer.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1).cgColor
////        postToTimey.layer.cornerRadius = 15
////
////        saveToCameraRoll.layer.backgroundColor = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1).cgColor
////        saveToCameraRoll.layer.cornerRadius = 15
////
////
////    }
////
////    @IBAction func shareActionButton(_ sender: UIButton){
////
////        if let video = VideoURL{
////            switch sender.tag{
////            case shareAction.twitter.rawValue:
////                self.composeTweet()
////
////            case shareAction.instagram.rawValue:
////                //This line will create the video, save it to the camera roll and open instagram to allow the user to post the video
////                //Note add error handaling if the user does not have the instagram app on the phone
////                ToCameraRoll(fileURL: video, completion: { (fileURL:String) in
////                    UIApplication.shared.open(URL(string:"instagram://library?LocalIdentifier=\(fileURL)")!, options: [:] , completionHandler: nil)
////                })
////
////            case shareAction.saveForLater.rawValue:
////                performSegue(withIdentifier: "SaveSegue", sender: nil)
////
////            case shareAction.postToTimey.rawValue:
////                if isSaved{
////                    saveVideoToDisk(videoUrl: video, completion: { (fileUrl) in
////                        let entity = NSEntityDescription.entity(forEntityName: "Done", in: self.manageContext)
////                        let object = NSManagedObject(entity:entity!,insertInto: self.manageContext)
////                        object.setValue(self.inProgressItem.title, forKeyPath: "title")
////                        object.setValue(fileUrl, forKey: "videoPath")
////                        object.setValue(Date(), forKeyPath: "createdAt")
////                        self.appDelegate.saveContext()
////                        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
////                    })
////                }
////                else{
////                    let alert = UIAlertController(title: "Nop", message: "You need to save for latter first.", preferredStyle: UIAlertControllerStyle.alert)
////                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////                    self.present(alert, animated: true, completion: nil)
////                }
////
////            case shareAction.saveToCameraRoll.rawValue:
////                ToCameraRoll(fileURL: video, completion: { (url:String) in
////                    let alert = UIAlertController(title: "Saved", message: "The video in located in your camera roll.", preferredStyle: UIAlertControllerStyle.alert)
////                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
////                    self.present(alert, animated: true, completion: nil)
////                })
////
////            default:
////                print("Some other thing is calling the post fuction ")
////            }
////        }
////
////    }
////
////    func saveVideoToDisk(videoUrl:URL, completion:@escaping (String) -> ()){
////        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
////
////            let fileName = String.uniqueFilename()+".mp4"
////            let fileURL = dir.appendingPathComponent(fileName)
////
////            do {
////                let videoData = try Data(contentsOf: videoUrl)
////                try videoData.write(to: fileURL)
////                completion(fileName)
////
////            }
////            catch {
////                print("error: Saving the video to disk.")
////            }
////        }
////    }
////
////    override var prefersStatusBarHidden: Bool {
////        return true
////    }
////
////
////    func composeTweet(){
////
////        createGIF(with: dataSource, frameDelay: Double(dataSource.count)*0.1) { (url) in
////
////            if (TWTRTwitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
////                // App must have at least one logged-in user to compose a Tweet
////                do{
////                    let gif = UIImage(data: try Data(contentsOf:url))
////                    let composer = TWTRComposer()
////                    //composer.setText("Made with Timey")
////                    composer.setImage(gif)
////                    // Called from a UIViewController
////                    composer.show(from: self) { (result) in
////                        if (result == .done) {
////                            print("Successfully composed Tweet")
////                        } else {
////                            print("Cancelled composing")
////                        }
////                    }
////
////                }
////                catch{
////
////                }
////            } else {
////                // Log in, and then check again
////                TWTRTwitter.sharedInstance().logIn { session, error in
////                    if session != nil { // Log in succeeded
////                        do{
////                            let gif = UIImage(data: try Data(contentsOf:url))
////                            let composer = TWTRComposer()
////                            composer.setText("Made with Timey")
////                            composer.setImage(gif)
////                            // Called from a UIViewController
////                            composer.show(from: self) { (result) in
////                                if (result == .done) {
////                                    print("Successfully composed Tweet")
////                                } else {
////                                    print("Cancelled composing")
////                                }
////                            }
////                        }
////                        catch{
////
////                        }
////
////                    } else {
////                        let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
////                        self.present(alert, animated: false, completion: nil)
////                    }
////                }
////            }
////
////
////
////        }
////    }
////
////    func ToCameraRoll(fileURL:URL, completion: @escaping (String) -> ()) {
////        PHPhotoLibrary.shared().performChanges({
////        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL) }) { saved, error in
////            if saved {
////                let fetchOptions = PHFetchOptions()
////                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
////                let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions).firstObject
////                completion((fetchResult?.localIdentifier)!)
////            }
////        }
////    }
////
////    @IBAction func dismissShareView(){
////        blurView.isHidden = true
////    }
////
////    @IBAction func post(){
////        //Show the share view
////        setUpShareView()
////        let settings = CXEImagesToVideo.videoSettings(codec: AVVideoCodecType.h264.rawValue, width: (dataSource[1].cgImage?.width)!, height: (dataSource[1].cgImage?.height)!)
////        let movieMaker = CXEImagesToVideo(videoSettings: settings, frameTime:CMTimeMake(1, 7))
////
////        movieMaker.createMovieFrom(images: dataSource){ (fileURL:URL) in
////            self.VideoURL = fileURL
////        }
////    }
////
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////
////        if let dest = segue.destination as? CameraViewController{
////            dest.isSaved = true
////            dest.delegate = self
////        }
////
////        if let dest = segue.destination  as? CreateTimeLapseViewController{
////            self.dataSource.remove(at: 0)
////            dest.imagesTaken = self.dataSource
////        }
////    }
////
////    func createGIF(with images: [UIImage], loopCount: Int = 0, frameDelay: Double, Completion: @escaping (URL)->()) {
////        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: loopCount]]
////        let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: frameDelay]]
////
////        let documentsDirectory = NSTemporaryDirectory()
////        let url = NSURL(fileURLWithPath: documentsDirectory).appendingPathComponent("myAnimatedGIF.gif")
////
////        let destination = CGImageDestinationCreateWithURL(url! as CFURL, kUTTypeGIF, Int(images.count), nil)
////        CGImageDestinationSetProperties(destination!, fileProperties as CFDictionary)
////
////        print(images.count)
////        for i in 0..<images.count {
////            CGImageDestinationAddImage(destination!, images[i].cgImage!, frameProperties as CFDictionary)
////        }
////
////        if CGImageDestinationFinalize(destination!) {
////           Completion(url!)
////        }
////    }
////}
////
////
////extension ImageCollectionViewController: cameraProtocal{
////    //Recive the images added to the time-lapse it's still not saved.
////    func didAddMoreImages(images:[UIImage]) {
////        imagesAdded += images
////        dataSource += images
////        if images.count != 0{
////            didUpadeDataSource = true
////            setUpPreview()
////        }
////
////
////
////    }
////}
////
////
////typealias CXEMovieMakerCompletion = (URL) -> Void
////typealias CXEMovieMakerUIImageExtractor = (AnyObject) -> UIImage?
////
////
////public class CXEImagesToVideo: NSObject{
////    var assetWriter:AVAssetWriter!
////    var writeInput:AVAssetWriterInput!
////    var bufferAdapter:AVAssetWriterInputPixelBufferAdaptor!
////    var videoSettings:[String : Any]!
////    var frameTime:CMTime!
////    var fileURL:URL!
////
////    var completionBlock: CXEMovieMakerCompletion?
////    var movieMakerUIImageExtractor:CXEMovieMakerUIImageExtractor?
////
////
////    public class func videoSettings(codec:String, width:Int, height:Int) -> [String: Any]{
////        if(Int(width) % 16 != 0){
////            print("warning: video settings width must be divisible by 16")
////        }
////        let videoSettings:[String: Any] = [AVVideoCodecKey: AVVideoCodecType.h264,
////                                           AVVideoWidthKey: width,
////                                           AVVideoHeightKey: height]
////
////
////        return videoSettings
////    }
////
////    public init(videoSettings: [String: Any], frameTime:CMTime) {
////        super.init()
////
////        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
////        let tempPath = paths[0] + "/exprotvideo.mp4"
////        if(FileManager.default.fileExists(atPath: tempPath)){
////            guard (try? FileManager.default.removeItem(atPath: tempPath)) != nil else {
////                print("remove path failed")
////                return
////            }
////        self.frameTime = frameTime
////
////        }
////
////        self.fileURL = URL(fileURLWithPath: tempPath)
////        self.assetWriter = try! AVAssetWriter(url: self.fileURL, fileType: AVFileType.mov)
////
////        self.videoSettings = videoSettings
////        self.writeInput = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoSettings)
////        assert(self.assetWriter.canAdd(self.writeInput), "add failed")
////
////        self.assetWriter.add(self.writeInput)
////        let bufferAttributes:[String: Any] = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32ARGB)]
////        self.bufferAdapter = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: self.writeInput, sourcePixelBufferAttributes: bufferAttributes)
////    }
////
////    func createMovieFrom(urls: [URL], withCompletion: @escaping CXEMovieMakerCompletion){
////        self.createMovieFromSource(images: urls as [AnyObject], extractor:{(inputObject:AnyObject) ->UIImage? in
////            return UIImage(data: try! Data(contentsOf: inputObject as! URL))}, withCompletion: withCompletion)
////    }
////
////    func createMovieFrom(images: [UIImage], withCompletion: @escaping CXEMovieMakerCompletion){
////        self.createMovieFromSource(images: images, extractor: {(inputObject:AnyObject) -> UIImage? in
////            return inputObject as? UIImage}, withCompletion: withCompletion)
////    }
////
////    func createMovieFromSource(images: [AnyObject], extractor: @escaping CXEMovieMakerUIImageExtractor, withCompletion: @escaping CXEMovieMakerCompletion){
////        self.completionBlock = withCompletion
////
////        self.assetWriter.startWriting()
////        self.assetWriter.startSession(atSourceTime: kCMTimeZero)
////
////        let mediaInputQueue = DispatchQueue(label: "mediaInputQueue")
////        var i = 0
////        let frameNumber = images.count
////
////        self.writeInput.requestMediaDataWhenReady(on: mediaInputQueue){
////            while(true){
////                if(i >= frameNumber){
////                    break
////                }
////
////                if (self.writeInput.isReadyForMoreMediaData){
////                    var sampleBuffer:CVPixelBuffer?
////                    autoreleasepool{
////                        let img = extractor(images[i])
////                        if img == nil{
////                            i += 1
////                            print("Warning: counld not extract one of the frames")
////                            //continue
////                        }
////                        sampleBuffer = self.newPixelBufferFrom(cgImage: img!.cgImage!)
////                    }
////                    if (sampleBuffer != nil){
////                        if(i == 0){
////                            self.bufferAdapter.append(sampleBuffer!, withPresentationTime: kCMTimeZero)
////                        }else{
////                            let value = i - 1
////                            let lastTime = CMTimeMake(Int64(value), self.frameTime.timescale)
////                            let presentTime = CMTimeAdd(lastTime, self.frameTime)
////                            self.bufferAdapter.append(sampleBuffer!, withPresentationTime: presentTime)
////                        }
////                        i = i + 1
////                    }
////                }
////            }
////            self.writeInput.markAsFinished()
////            self.assetWriter.finishWriting {
////                DispatchQueue.main.sync {
////                    self.completionBlock!(self.fileURL)
////                }
////            }
////        }
////    }
////
////    func newPixelBufferFrom(cgImage:CGImage) -> CVPixelBuffer?{
////        let options:[String: Any] = [kCVPixelBufferCGImageCompatibilityKey as String: true, kCVPixelBufferCGBitmapContextCompatibilityKey as String: true]
////        var pxbuffer:CVPixelBuffer?
////        let frameWidth = self.videoSettings[AVVideoWidthKey] as! Int
////        let frameHeight = self.videoSettings[AVVideoHeightKey] as! Int
////
////        let status = CVPixelBufferCreate(kCFAllocatorDefault, frameWidth, frameHeight, kCVPixelFormatType_32ARGB, options as CFDictionary?, &pxbuffer)
////        assert(status == kCVReturnSuccess && pxbuffer != nil, "newPixelBuffer failed")
////
////        CVPixelBufferLockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0))
////        let pxdata = CVPixelBufferGetBaseAddress(pxbuffer!)
////        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
////        let context = CGContext(data: pxdata, width: frameWidth, height: frameHeight, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pxbuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
////        assert(context != nil, "context is nil")
////
////        context!.concatenate(CGAffineTransform.identity)
////        context!.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
////        CVPixelBufferUnlockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0))
////        return pxbuffer
////    }
//}
