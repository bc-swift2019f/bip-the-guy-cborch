//
//  ViewController.swift
//  Bip The Guy!
//
//  Created by Carter Borchetta on 9/16/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Mark: Properties
    @IBOutlet weak var imageToPunch: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Mark: Functions
    func animateImage() {
        let bounds = self.imageToPunch.bounds
        // Self means its in the current view of the iPhone that I'm looking at
        let shrinkValue: CGFloat = 60
        
        // Shrink our imageToPunch by 60 pixels
        self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + shrinkValue, y: self.imageToPunch.bounds.origin.y + shrinkValue, width: self.imageToPunch.bounds.size.width - shrinkValue, height: self.imageToPunch.bounds.size.height - shrinkValue)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.imageToPunch.bounds = bounds }, completion: nil)
        
    }
    
    // Mark: ACTIONS
    @IBAction func libraryPressed(_ sender: UIButton) {
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
    }
}

// 4.2 Notes
// iPhone Cordinate system
// - 0,0 is in the top left corner
// Use apples core graphics to inreract with cordniate system
// CGPoint = 2 CG floats
// You use .frame to access cordinate info relative to the super view
// You use .bounds referring to the cordinat system within the frame

// Everything from IB is inherted from the UIView Class
// - So we can animate anything we put on the View Controller
