//
//  ViewController.swift
//  Canvas
//
//  Created by Joseph Andy Feidje on 11/2/18.
//  Copyright © 2018 Softmatech. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var faceCreatedCenter: CGPoint!
    var newCreatedFace: UIImageView!
    var originalCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
        trayCenterWhenOpen = self.trayView.center
        trayCenterWhenClosed = CGPoint(x: self.trayView.center.x, y: self.trayView.center.y + 160)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            print("Gesture began")
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            print("Gesture is changing")
//            view.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            print("Gesture ended")
//            let velocity = sender.velocity(in: view)
          
            if sender.velocity(in: trayView).y > 0 {
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,animations: { () -> Void in
                self.trayView.center = self.trayDown
                }, completion: nil)
                self.trayView.center =  self.trayCenterWhenClosed
            }
            else
            {
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,animations: { () -> Void in
                self.trayView.center = self.trayDown
                }, completion: nil)
                self.trayView.center = self.trayCenterWhenOpen
            }
        }
    }
    
    @IBAction func didPanface(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            faceCreatedCenter = sender.view?.center
            let imageView = sender.view as! UIImageView
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanface(sender:)))
            newCreatedFace = UIImageView(image: imageView.image)
            newCreatedFace.isUserInteractionEnabled = true
            newCreatedFace.addGestureRecognizer(panGesture)
            view.addSubview(newCreatedFace)

            newCreatedFace.center = imageView.center
            newCreatedFace.center.y += trayView.frame.origin.y
        } else if sender.state == .changed {
            newCreatedFace.center = CGPoint(x: faceCreatedCenter.x + sender.translation(in: newCreatedFace).x, y: 347 + faceCreatedCenter.y + sender.translation(in: newCreatedFace).y)

        } else if sender.state == .ended {

        }
    }
    
    @objc func didPanface(sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            originalCenter = (sender.view?.center)!
            sender.view?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } else if sender.state == .changed {
            sender.view?.center = CGPoint(x: (originalCenter.x) + sender.translation(in: sender.view).x, y: (originalCenter.y) + sender.translation(in: sender.view).y)
        } else if sender.state == .ended {
            sender.view?.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapTray(_ sender: UITapGestureRecognizer) {
//        trayView.removeFromSuperview()
    }
    
    @IBAction func didPinchTray(_ sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            originalCenter = (sender.view?.center)!
            sender.view?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        } else if sender.state == .changed {
//            sender.view?.center = CGPoint(x: (originalCenter.x) + sender.translation(in: sender.view).x, y: (originalCenter.y) + sender.translation(in: sender.view).y)
        } else if sender.state == .ended {
            sender.view?.transform = CGAffineTransform.identity
        }
    }
    
    
}

