//
//  ScrollView.swift
//  testScrollView
//
//  Created by Viet Anh Doan on 6/29/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit

class ScrollView: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var photo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scroll and zoom
        let image = UIImage(named: "shop1-0.jpg")
        let imageView = UIImageView(image: image)
        photo = imageView
        scrollView.contentSize = CGSize(width: imageView.bounds.size.width, height: imageView.bounds.size.height)
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        scrollView.addSubview(imageView)
        
        //tab
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        tap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tap)
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        tap.require(toFail: doubleTap)
        scrollView.addGestureRecognizer(doubleTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photo
    }
    
    func onTap(gesture: UIGestureRecognizer) -> Void {
        let location = gesture.location(in: photo)
        zoomBy(scale: 1.5, center: location)
    }
    
    func onDoubleTap(gesture: UIGestureRecognizer) -> Void {
        let location = gesture.location(in: photo)
        zoomBy(scale: 0.5, center: location)
    }
    
    func zoomBy(scale: CGFloat, center: CGPoint) -> Void {
        var zoomRect = CGRect()
        let size = scrollView.bounds.size
        let scrollScale = scrollView.zoomScale * scale
        zoomRect.size.width = size.width / scrollScale
        zoomRect.size.height = size.height / scrollScale
        zoomRect.origin.x = center.x - zoomRect.size.width/2
        zoomRect.origin.y = center.y - zoomRect.size.height/2
        print(zoomRect)
        scrollView.zoom(to: zoomRect, animated: true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        print(sender.value)
        let value = CGFloat(sender.value)/4 + 0.875
        print(value)
        zoomBy(scale: value, center: scrollView.center)
    }

}
