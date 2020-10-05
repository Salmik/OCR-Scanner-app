//
//  CaptureDevice.swift
//  WeScan
//
//  Created by Julian Schiavo on 28/11/2018.
//  Copyright © 2018 WeTransfer. All rights reserved.
//

import Foundation
import AVFoundation

protocol CaptureDevice: class {
    var torchMode: AVCaptureDevice.TorchMode { get set }
    var isTorchAvailable: Bool { get }
    
    var focusMode: AVCaptureDevice.FocusMode { get set }
    var focusPointOfInterest: CGPoint { get set }
    var isFocusPointOfInterestSupported: Bool { get }
    
    var exposureMode: AVCaptureDevice.ExposureMode { get set }
    var exposurePointOfInterest: CGPoint { get set }
    var isExposurePointOfInterestSupported: Bool { get }

    var isSubjectAreaChangeMonitoringEnabled: Bool { get set }

    func isFocusModeSupported(_ focusMode: AVCaptureDevice.FocusMode) -> Bool
    func isExposureModeSupported(_ exposureMode: AVCaptureDevice.ExposureMode) -> Bool
    func unlockForConfiguration()
    func lockForConfiguration() throws
}

extension AVCaptureDevice: CaptureDevice { }

final class MockCaptureDevice: CaptureDevice {
    var torchMode: AVCaptureDevice.TorchMode = .off
    var isTorchAvailable: Bool = true
    
    var focusMode: AVCaptureDevice.FocusMode = .continuousAutoFocus
    var focusPointOfInterest: CGPoint = .zero
    var isFocusPointOfInterestSupported: Bool = true
    
    var exposureMode: AVCaptureDevice.ExposureMode = .continuousAutoExposure
    var exposurePointOfInterest: CGPoint = .zero
    var isExposurePointOfInterestSupported: Bool = true
    var isSubjectAreaChangeMonitoringEnabled: Bool = false

    func unlockForConfiguration() {
        return
    }

    func lockForConfiguration() throws {
        return
    }

    func isFocusModeSupported(_ focusMode: AVCaptureDevice.FocusMode) -> Bool {
        return true
    }
    
    func isExposureModeSupported(_ exposureMode: AVCaptureDevice.ExposureMode) -> Bool {
        return true
    }
}
