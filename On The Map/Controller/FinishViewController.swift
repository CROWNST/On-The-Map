//
//  FinishViewController.swift
//  On The Map
//
//  Created by David Hsieh on 8/5/21.
//

import UIKit
import MapKit

class FinishViewController: UIViewController {

    var studentInformation: StudentInformation!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let lat = CLLocationDegrees(studentInformation.latitude)
        let long = CLLocationDegrees(studentInformation.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        let mapViewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 32180, longitudinalMeters: 32180)
        mapView.region = mapViewRegion
    }
    
    @IBAction func finishTapped(_ sender: Any) {
        APIClient.postStudentLocation(studentInformation: studentInformation, completion: handlePostStudentLocation(success:error:))
    }
    
    func handlePostStudentLocation(success: Bool, error: Error?) {
        if success {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.showFailureMessage(message: error?.localizedDescription ?? "")
        }
    }
}

extension FinishViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.pinTintColor = .red
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
}
