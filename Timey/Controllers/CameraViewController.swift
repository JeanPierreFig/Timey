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

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var lastImageTakenView: UIImageView!
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var imagesTaken = [UIImage]()
    
    
    
    
    
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        //Draw camera button on screen.
        cameraButton.layer.masksToBounds = true
        cameraButton.layer.cornerRadius = cameraButton.frame.width/2
        cameraButton.layer.borderWidth = 6
        cameraButton.layer.borderColor = (UIColor.white).cgColor
    
        createButton.isHidden = true
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 15
        createButton.layer.backgroundColor = UIColor.white.cgColor

        createSession()
        setupInputOutput()
        createCameraOverlay()
        startSession()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func createSession(){
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        if currentCamera == nil{
            
            currentCamera = frontCamera
        }
        else if currentCamera == frontCamera{
            
             currentCamera = backCamera
        }
        else{
            currentCamera = frontCamera
        }
       
        
    }
    
    func setupInputOutput(){
        do{
            let captureDeviceinput = try AVCaptureDeviceInput(device: currentCamera!)
            photoOutput = AVCapturePhotoOutput()
            captureSession.addInput(captureDeviceinput)
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }
        catch{
            
        }
    }
    
    func createCameraOverlay(){
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session:captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startSession(){
        captureSession.startRunning()
    }
    
    @IBAction func rotate(sender:UIButton){
        sender.layer.shadowColor = UIColor.green.cgColor
        sender.layer.shadowRadius = 10
        sender.layer.shadowOffset = CGSize.zero
        sender.layer.masksToBounds = false
        
        captureSession.beginConfiguration()
        captureSession.removeInput(captureSession.inputs[0])
        captureSession.removeOutput(captureSession.outputs[0])
        createSession()
        setupInputOutput()
        captureSession.commitConfiguration()
        
        UIView.animate(withDuration: 0.25, animations: {
            sender.transform = sender.transform.rotated(by: -360)
        })
    }
    
    @IBAction func captureImage(sender: UIButton){
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        photoOutput?.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    
    @IBAction func dismiss(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  let navVC = segue.destination as? UINavigationController ,
            let dest = navVC.viewControllers.first as? CreateTimeLapseViewController{
            dest.imagesTaken = self.imagesTaken
        }
    }
    
    func showFace(){
        
//        let detectFaceRequest = VNDetectFaceLandmarksRequest { (request, error) in
//            if error == nil {
//                if let results = request.results as? [VNFaceObservation] {
//                    print("Found \(results.count) faces")
//                    for faceObservation in results {
//                        guard let landmarks = faceObservation.landmarks else {
//                            continue
//                        }
//                        let boundingRect = faceObservation.boundingBox
//                        var landmarkRegions: [VNFaceLandmarkRegion2D] = []
//                        if let faceContour = landmarks.faceContour {
//                            landmarkRegions.append(faceContour)
//                        }
//                        if let leftEye = landmarks.leftEye {
//                            landmarkRegions.append(leftEye)
//                        }
//                        if let rightEye = landmarks.rightEye {
//                            landmarkRegions.append(rightEye)
//                        }
//
//                        //handle landmark regions
//
//                    }
//                }
//            } else {
//                print(error!.localizedDescription)
//            }
           // complete(resultImage)
        //}
      //  let vnImage = VNImageRequestHandler(cgImage: source.cgImage!, options: [:])
        //try? vnImage.perform([detectFaceRequest])
    }
    
    //MARK: AVCapturePhotoCaptureDelegate
    
    //Convert image data to UIImage and add it to the imagsTaken array.
    //Set the image to the image preview view in the corner of the screen.
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData){
            createButton.isHidden = false
            imagesTaken.append(image)
            print(imagesTaken.count)
            lastImageTakenView.image = image
            if currentCamera?.position == AVCaptureDevice.Position.front{
            lastImageTakenView.transform = CGAffineTransform(scaleX: -1, y: 1); //Flipped
            }
        }
    }
    

}

