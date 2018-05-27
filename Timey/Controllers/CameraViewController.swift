//
//  CameraViewViewController.swift
//  Timey
//
//  Created by Jean Pierre on 1/15/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit
import AVFoundation
import Vision
//
//protocol cameraProtocal {
//    func didAddMoreImages(images:[UIImage])
//}
//
//class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
//     var delegate:cameraProtocal?
//    @IBOutlet var cameraButton: UIButton!
//    @IBOutlet var createButton: UIButton!
//    @IBOutlet var backButton: UIButton!
//    @IBOutlet var flipButton: UIButton!
//    @IBOutlet var lastImageTakenView: UIImageView!
//    var captureSession = AVCaptureSession()
//    var backCamera: AVCaptureDevice?
//    var frontCamera: AVCaptureDevice?
//    var currentCamera: AVCaptureDevice?
//    var photoOutput: AVCapturePhotoOutput?
//    var imagesTaken = [UIImage]()
//    var isSaved = false
//    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //Draw camera button on screen.
//        cameraButton.layer.masksToBounds = true
//        cameraButton.layer.cornerRadius = cameraButton.frame.width/2
//        cameraButton.layer.borderWidth = 6
//        cameraButton.layer.borderColor = (UIColor.white).cgColor
//        
//        flipButton.layer.shadowColor = UIColor.black.cgColor
//        flipButton.layer.shadowRadius = 5
//        flipButton.layer.shadowOpacity = 1
//        
//        if isSaved == false {
//            createButton.isHidden = true
//            createButton.layer.masksToBounds = true
//            createButton.layer.cornerRadius = 15
//            createButton.layer.backgroundColor = UIColor.white.cgColor
//        }
//        else{
//            backButton.setTitle("Done", for: UIControlState.normal)
//            createButton.isHidden = true
//        }
//        
//        createSession()
//        setupInputOutput()
//        createCameraOverlay()
//        startSession()
//    }
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//    
//    func createSession() {
//        captureSession.sessionPreset = AVCaptureSession.Preset.high
//        
//        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
//        let devices = deviceDiscoverySession.devices
//        
//        for device in devices {
//            if device.position == AVCaptureDevice.Position.back{
//                backCamera = device
//            }
//            else if device.position == AVCaptureDevice.Position.front {
//                frontCamera = device
//            }
//        }
//        
//        if currentCamera == nil{
//            
//            currentCamera = frontCamera
//        }
//        else if currentCamera == frontCamera{
//            
//             currentCamera = backCamera
//        }
//        else{
//            currentCamera = frontCamera
//        }
//    }
//    
//    func setupInputOutput() {
//        do{
//            let captureDeviceinput = try AVCaptureDeviceInput(device: currentCamera!)
//            photoOutput = AVCapturePhotoOutput()
//            captureSession.addInput(captureDeviceinput)
//            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
//            captureSession.addOutput(photoOutput!)
//        }
//        catch{
//        }
//    }
//    
//    func createCameraOverlay() {
//        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session:captureSession)
//        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
//        cameraPreviewLayer?.frame = self.view.frame
//        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
//    }
//    
//    func startSession() {
//        captureSession.startRunning()
//    }
//    
//    @IBAction func rotate(sender:UIButton) {
//        captureSession.beginConfiguration()
//        captureSession.removeInput(captureSession.inputs[0])
//        captureSession.removeOutput(captureSession.outputs[0])
//        createSession()
//        setupInputOutput()
//        captureSession.commitConfiguration()
//        
//        UIView.animate(withDuration: 0.25, animations: {
//            sender.transform = sender.transform.rotated(by: -360)
//        })
//    }
//    
//    @IBAction func captureImage(sender: UIButton) {
//        let generator = UIImpactFeedbackGenerator(style: .heavy)
//        generator.impactOccurred()
//        photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
//    }
//    
//    @IBAction func dismiss(sender:UIButton) {
//        if isSaved == true{
//            self.delegate?.didAddMoreImages(images: imagesTaken)
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if let dest = segue.destination  as? ImageCollectionViewController{
//            dest.isSaved = self.isSaved
//            dest.imagesTaken = self.imagesTaken
//        }
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
//    //MARK: AVCapturePhotoCaptureDelegate
//    
//    //Convert image data to UIImage and add it to the imagsTaken array.
//    //Set the image to the image preview view in the corner of the screen.
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData){
//            if isSaved == false{
//                if imagesTaken.count >= 1{
//                    createButton.isHidden = false
//                }
//            }
//            
//            imagesTaken.append(removeRotationForImage(image: image))
//            lastImageTakenView.image = removeRotationForImage(image: image)
//            if currentCamera?.position == AVCaptureDevice.Position.front{
//            lastImageTakenView.transform = CGAffineTransform(scaleX: -1, y: 1); //Flipped
//            }
//        }
//    }
//}
//
