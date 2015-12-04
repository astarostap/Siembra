//
//  ProfileViewController.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet var characteristicsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    private func setImage() {
        let image = UIImage(named: "lisa.jpg")
        imageView.image = image
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.purpleColor().CGColor
    }
    
    private func setName() {
        nameLabel.text = "Lisa Hummel"
    }
    
    private func setCharacteristics() {
        characteristicsLabel.text = "PM at Twitter, dog lover, traveller."
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setName()
        setCharacteristics()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
