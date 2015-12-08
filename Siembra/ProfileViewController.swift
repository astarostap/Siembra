//
//  ProfileViewController.swift
//  Siembra
//
//  Created by Quentin Perrot on 12/3/15.
//  Copyright © 2015 Abraham Starosta. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import CoreLocation

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet var characteristicsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!

    // This function allows the user to choose a new profile picture from her library of photos on her device. It uses the UIImagePickerController.
    @IBAction func choosePictureFromLibrary(sender: UIButton) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = editingInfo![UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    // This function allows the user to change their profile picture by taking a picture using their device's camera. This also uses the UIImagePickerController. 
    // This feature was inspired from a tutorial at http://www.ioscreator.com/tutorials/take-photo-tutorial-ios8-swift
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // This function is called when the user first comes to this controller and sets the image view to be the appropriate image.
    private func setImage() {
        let image = UIImage(named: "lisa.jpg")
        imageView.image = image
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.purpleColor().CGColor
    }
    
    // This function sets the user's name in the profile view.
    private func setName() {
        nameLabel.text = "Lisa Hummel"
    }
    
    // This function sets the user's subtitle characteristics in the profile view.
    private func setCharacteristics() {
        characteristicsLabel.text = "PM at Twitter & dog lover"
    }

    // This function will set up the map that is found on the profile view.
    private func setupMap() {
        
        // Fetch address from Core Data
        if let context = AppDelegate.managedObjectContext {
            var address = ""
            if let user = User.findUser("Lisa", inManagedObjectContext: context) {
                address = user.address!
            }
            
            // Create map
            var placemark: CLPlacemark!
            CLGeocoder().geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                if error == nil {
                    placemark = placemarks![0] as CLPlacemark
                    self.mapView.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2DMake (placemark.location!.coordinate.latitude, placemark.location!.coordinate.longitude), MKCoordinateSpanMake(0.002, 0.002)), animated: true)
                    self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                }
            })
        }
    }

    // When the view first loads, set up all that is required for the profile view to function correctly.
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setName()
        setCharacteristics()
        setupMap()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    // This popover segue gives users the ability to see the user's best story
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popOverSegue" {
            if let popoverViewController = segue.destinationViewController as? PopoverViewController {
                popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                popoverViewController.popoverPresentationController!.delegate = self
                if let context = AppDelegate.managedObjectContext {
                    if let user = User.findUser("Lisa", inManagedObjectContext: context) {
                        if let stories = user.publications!.allObjects as? [Story] {
                            if let story = stories.first {
                                popoverViewController.setStory(story.text)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }


}
