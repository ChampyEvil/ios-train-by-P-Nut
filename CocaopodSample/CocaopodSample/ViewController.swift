//
//  ViewController.swift
//  CocaopodSample
//
//  Created by Thirawuth on 22/11/2563 BE.
//

import UIKit
import LocalAuthentication
import AVFoundation
import Photos

class ViewController: UIViewController {

    private let biometricsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Biometrics", for: .normal)
        return button
    }()
    
    private let openCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open Camera", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        biometricsButton.frame = CGRect(x: 0, y: 200, width: 200, height: 200)
        openCameraButton.frame = CGRect(x: 0, y: 400, width: 200, height: 200)
        view.addSubview(biometricsButton)
        view.addSubview(openCameraButton)
        
        biometricsButton.addTarget(self, action: #selector(onBiometricsButton), for: .touchUpInside)
        openCameraButton.addTarget(self, action: #selector(onOpenCamera), for: .touchUpInside)
    }

    @objc func onBiometricsButton() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log In") { (success, error) in
                if success {
                    print("biometrics Success")
                } else {
                    guard let _error = error else {return}
                    print("biometrics fail :: \(_error)")
                }
            }
        } else {
            print("biometrics not support")
        }
    }
    
    @objc func onOpenCamera() {
        present(CameraPreviewViewController(),animated: true, completion: .none)
    }
}

class CameraPreviewViewController: UIViewController {
    
    private var session: AVCaptureSession?
    private let photoOutput: AVCapturePhotoOutput = {
        let output = AVCapturePhotoOutput()
        output.isHighResolutionCaptureEnabled = true
        return output
    }()
    
    private let capturePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Capture", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        capturePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(capturePhotoButton)
        
        NSLayoutConstraint.activate([
            capturePhotoButton.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0.5),
            capturePhotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCamera()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        session?.stopRunning()
    }
    
    private func startCamera() {
        guard !(session?.isRunning ?? false) else { return }
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            startPreview()
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] (granted) in
                guard let self = self else { return }
                guard granted else {return}
                self.startPreview()
            }
            break // open permission dialog
        default:
//            open dialog message
            break //fail case
//        มันคือ fail ทั้งคุ่ ถือว่าเป็น default
//        case .denied: break
//        case .restricted: break // parent control
        }
    }
    
    private func startPreview() {
        
        let list = AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                .builtInDualCamera,
                .builtInDualWideCamera,
                .builtInTelephotoCamera,
                .builtInTripleCamera,
                .builtInWideAngleCamera,
                .builtInUltraWideCamera
            ],
            mediaType: .video,
            position: .unspecified)
        
        let devices = list.devices
        
//        guard let captureDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) else {return .none}
        guard let captureDevice = devices.first else {return}
        let deviceInput = try? AVCaptureDeviceInput(device: captureDevice)
//        let deviceInput: AVCaptureDeviceInput? = {
//            guard let captureDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) else {return .none}
//            return try? AVCaptureDeviceInput(device: captureDevice)
//        }()
        
        self.session = AVCaptureSession()
        self.session?.sessionPreset = .hd1920x1080
        self.session?.addInput(deviceInput!)
        self.session?.commitConfiguration()
        
        DispatchQueue.main.async {
            let previewLayer = AVCaptureVideoPreviewLayer(session: self.session!)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = self.view.frame
            
            self.view.layer.addSublayer(previewLayer)
            self.view.bringSubviewToFront(self.capturePhotoButton)
            self.session?.startRunning()
        }
    }
}
