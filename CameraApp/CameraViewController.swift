//
//  CameraViewController.swift
//  CameraApp
//
//  Created by 舘佳紀 on 2020/01/23.
//  Copyright © 2020 yoshiki Tachi. All rights reserved.
//

import UIKit
import GPUImage



class CameraViewController: UIViewController {
    
    //カメラの制御
    fileprivate var maincamera : GPUImageStillCamera?
    
    fileprivate var previewView : GPUImageView?
    
    let mainScreensize : CGSize = UIScreen.main.bounds.size
    
    override var prefersStatusBarHidden: Bool {
           return true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CameraInit()
        
        view.addSubview(shutterButton)

    }
    
    lazy var shutterButton : UIButton = {
        let frame : CGRect = CGRect(x : 0, y : 0, width : 80, height : 80)
        let button : UIButton = UIButton(frame: frame)
        let image : UIImage = UIImage(named: "Shutter_Button")!
        button.setBackgroundImage(image, for: .normal)
        button.center = CGPoint(x : ((mainScreensize.width) / 2), y : (previewView?.frame.maxY)! + (mainScreensize.height - (previewView?.frame.maxY)! ) / 2)
        button.addTarget(self, action: #selector(onShutterButtonClicked(sender:)), for: .touchUpInside)
        print("hoge")
        return button
    }()
    
    @objc func onShutterButtonClicked(sender : AnyObject){
        capturePhotoProcess()
    }
    
    func capturePhotoProcess() {
        let cropFilter = GPUImageCropFilter(cropRegion: CGRect(x: 0, y: 0, width: 1, height: 1))
        maincamera?.addTarget(cropFilter)
        maincamera?.capturePhotoAsImageProcessedUp(toFilter: cropFilter, withCompletionHandler: { (image, error) in UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)})
    }
    
    func CameraInit() {
        maincamera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.photo.rawValue, cameraPosition: .back)
        maincamera!.outputImageOrientation = .portrait
        previewView = GPUImageView(frame: CGRect(x: 0, y: 0, width: mainScreensize.width, height: ( mainScreensize.width / 3) * 4))
        maincamera?.addTarget(previewView)
        view.addSubview(previewView!)
        
        maincamera?.startCapture()
    }
    
}
