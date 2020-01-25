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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CameraInit()

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
