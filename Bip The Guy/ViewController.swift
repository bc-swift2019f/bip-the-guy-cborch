//
//  ViewController.swift
//  Bip The Guy!
//
//  Created by Carter Borchetta on 9/16/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // Mark: Properties
    @IBOutlet weak var imageToPunch: UIImageView!
    var audioPlayer = AVAudioPlayer()
    // variable of type AVAudioPlayer
    
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
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file soudName?
        if let sound = NSDataAsset(name: soundName) {
            // Now check if sound.data is a sound file(not just checking nil anymore)
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
                //print(soundName)
            } catch {
                // if sound.data is not a valid audio file
                print("Error: data in \(soundName) couldn't be played as a sound")
            }
            
        } else {
            // if reading in the NSDataasset didn't work throw an error
            print("Error: file \(soundName) didn't load")
        }
    }

    
    // Mark: ACTIONS
    @IBAction func libraryPressed(_ sender: UIButton) {
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
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
