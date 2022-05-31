//
//  MapViewController.swift
//  On The Map
//
//  Created by David Hsieh on 8/5/21.
//

import UIKit
import MapKit

class StudentLocationsMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        refresh()
    }
    
    func refresh() {
        APIClient.getStudentLocations(completion: handleGetStudentLocations(studentLocations:error:))
    }
    
    func handleGetStudentLocations(studentLocations: [StudentInformation], error: Error?) {
        if error == nil {
            StudentInformationModel.studentInformationList = studentLocations
            self.updateMapView()
        } else {
            self.showFailureMessage(message: error?.localizedDescription ?? "")
        }
    }
    
    func updateMapView() {
        mapView.removeAnnotations(mapView.annotations)
        var annotations = [MKPointAnnotation]()
        for studentInformation in StudentInformationModel.studentInformationList {
            let lat = CLLocationDegrees(studentInformation.latitude)
            let long = CLLocationDegrees(studentInformation.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let first = studentInformation.firstName
            let last = studentInformation.lastName
            let mediaURL = studentInformation.mediaURL
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
    }
}

extension StudentLocationsMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                if let url = URL(string: toOpen) {
                    app.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
