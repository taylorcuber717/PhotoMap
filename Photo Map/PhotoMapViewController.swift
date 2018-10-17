//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {
    
    
    
    @IBOutlet weak var theMapView: MKMapView!
    @IBAction func didPressCameraButton(_ sender: Any) {
        let photoLibraryView = UIImagePickerController()
        photoLibraryView.delegate = self
        photoLibraryView.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            photoLibraryView.sourceType = .camera
        } else {
            photoLibraryView.sourceType = .photoLibrary
        }
        self.present(photoLibraryView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let TucsonRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(32.2226, -110.9747), MKCoordinateSpanMake(0.05, 0.05))
        theMapView.setRegion(TucsonRegion, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print(editedImage)
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "tagSegue", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let locationsView = segue.destination as! LocationsViewController
        locationsView.delegate = self
    }
    
    // Protocol Function
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        //print("Lat: \(latitude), Lng: \(longitude)")
        let locationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        self.navigationController?.popToViewController(self, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        theMapView.addAnnotation(annotation)
    }

}
