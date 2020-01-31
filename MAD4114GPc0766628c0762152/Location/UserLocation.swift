//
//  UserLocation.swift
//  MAD4114GPc0766628c0762152
//
//  Created by SanDEV on 2020-01-18.
//  Copyright © 2020 SanDEV. All rights reserved.
//
import UIKit
import MapKit

class UserLocationViewController: UIViewController , CLLocationManagerDelegate{
    // - Constants
   var manager = CLLocationManager()
    @IBOutlet weak var map: MKMapView!
    var myString: String = ""
    @IBOutlet weak var addLocation: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
       {
           let location = locations[0]
        let span =  MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
           let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        DispatchQueue.main.async {
            self.map.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            self.map.addAnnotation(annotation)
           self.map.showsUserLocation = true
           CLGeocoder().reverseGeocodeLocation(location)
        {
            (placemark, error) in
               if error != nil
               {
                   print ("THERE WAS AN ERROR")
               }
               else
               {
                   if let place = placemark?[0]
                   {
                    if place.subThoroughfare != nil
                       {
                           self.locationLabel.text = "your Current Location is:- \n\(place.subThoroughfare!)  \(place.thoroughfare!)  \(place.country!)"
                       }
                   }
               }
           }
       }
       }
    //adding location with note
    @IBAction func AddLocationBTN(_ sender: UIButton) {
        let alertBox = UIAlertController(title: "Location", message: "LocationSaved", preferredStyle: .alert)
alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertBox, animated: true, completion: nil)}
      }

