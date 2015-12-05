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
    @IBOutlet weak var addressLabel: UILabel!

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
    
    private func setImage() {
        let image = UIImage(named: "lisa.jpg")
        imageView.image = image
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor = UIColor.purpleColor().CGColor
    }
    
    private func setName() {
        nameLabel.text = "Lisa Hummel"
    }
    
    private func setCharacteristics() {
        characteristicsLabel.text = "PM at Twitter & dog lover"
    }

    private func setupMap() {
        
        // Fetch address from Core Data
        if let context = AppDelegate.managedObjectContext {
            var address = ""
            if let user = User.findUser("Lisa", inManagedObjectContext: context) {
                address = user.address!
                addressLabel.text = address
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
