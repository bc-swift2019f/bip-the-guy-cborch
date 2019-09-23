//
//  ViewController.swift
//  Bip The Guy!
//
//  Created by Carter Borchetta on 9/16/19.
//  Copyright © 2019 Carter Borchetta. All rights reserved.
//  Class Version

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // Mark: Properties
    @IBOutlet weak var imageToPunch: UIImageView!
    var audioPlayer = AVAudioPlayer()
    // Variable of type AVAudioPlayer
    var imagePicker = UIImagePickerController()
    // Variable of type UIImagePicker
    // UIImagePickerController = a class, which is a blueprint containing data fields and methods
    // - Here we are creating an object of the class like doing new in Java
    
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        // User has succesfully selected an images lets grab it from the dictionary info and slap it into selectedImage as a UIImage
        imageToPunch.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // UIAlertController object and passing parameters to the class
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        // Create the action
        // Handler if you want some code to run once OK pressed
        alertController.addAction(action)
        // Add the UIAlertAction to the UIAlertController
        present(alertController, animated: true, completion: nil)
    }

    
    // Mark: ACTIONS
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        // To connect the imagePicker to the view controller
        // - Self is jsut referring to the view controller
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device")
        }

    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
    }
}

// 4.4 Notes
// Part of UIImagePicker protocol is that when it is done picking an image it calls the function func imagePickerController
// - We have to actually implement what this func will do
// Also creates the func imagePickerControllerDidCancel that we have to implement

// 4.2 Notes
// iPhone Cordinate system
// - 0,0 is in the top left corner
// Use apples core graphics to inreract with cordniate system
// CGPoint = 2 CG floats
// You use .frame to access cordinate info relative to the super view
// You use .bounds referring to the cordinat system within the frame

// Everything from IB is inherted from the UIView Class
// - So we can animate anything we put on the View Controller
