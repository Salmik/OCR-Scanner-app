//
//  ImageScrollView.swift
//  OCRApp
//
//  Created by Zhanibek Lukpanov on 03.06.2020.
//  Copyright © 2020 Zhanibek Lukpanov. All rights reserved.
//

import UIKit

public class ImageScrollView: UIScrollView, UIScrollViewDelegate {
    
    var imageZoomView: UIImageView!
    
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.centerImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage) {
        
        imageZoomView?.removeFromSuperview()
        imageZoomView = nil
        
        imageZoomView = UIImageView(image: image)
        self.addSubview(imageZoomView)
        
        configurator(imageSize: image.size)
    }
    
    func configurator(imageSize: CGSize) {
        
        self.contentSize = imageSize
        
        setCurrentMaxMinZoomScale()
        
        self.zoomScale = self.minimumZoomScale
        
        self.imageZoomView.addGestureRecognizer(self.zoomingTap)
        self.imageZoomView.isUserInteractionEnabled = true
    }
    
    func setCurrentMaxMinZoomScale() {
        
        let boundSize = self.bounds.size
        let imageSize = imageZoomView.bounds.size
        
        let yScale = boundSize.width / imageSize.width
        let xScale = boundSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        var maxScale: CGFloat = 1.0
        
        if minScale < 0.1 {
            maxScale = 0.3
        }
        
        if minScale >= 0.1 && maxScale < 0.5 {
            maxScale = 0.7
        }
        
        if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }
        
        self.minimumZoomScale = minScale
        
    }
    
    func centerImage() {
        
        let boundsSize = self.bounds.size
        var frametoCenter = imageZoomView.frame ?? CGRect.zero
        
        if frametoCenter.size.width < boundsSize.width {
            frametoCenter.origin.x = (boundsSize.width - frametoCenter.size.width) / 2
        } else {
            frametoCenter.origin.x = 0
            
        }
        
        if frametoCenter.size.height < boundsSize.height {
            frametoCenter.origin.y = (boundsSize.height - frametoCenter.size.height) / 2
        } else {
            frametoCenter.origin.y = 0
        }
        
        imageZoomView.frame = frametoCenter
    }
    
    // MARK: - Tap Gesture work
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.zoom(point: location, animated: true)
    }
    
    func zoom(point: CGPoint, animated: Bool) {
        
        let currentScale = self.zoomScale
        let minsScale = self.minimumZoomScale
        let maxScale = self.maximumZoomScale
        
        if (minsScale == maxScale && minsScale > 1) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currentScale == minsScale) ? toScale : minsScale
        let zoomRect = self.zoomRect(scale: finalScale, center: point)
        
        self.zoom(to: zoomRect, animated: animated)
    }
    
    func zoomRect(scale: CGFloat, center: CGPoint)-> CGRect {
        var zoomRect = CGRect.zero
        let bounds = self.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        return zoomRect
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageZoomView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
}
