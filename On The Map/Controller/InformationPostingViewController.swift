//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by David Hsieh on 8/5/21.
//

import UIKit
import CoreLocation

class InformationPostingViewController: UIViewController {

    var studentInformation = StudentInformation(uniqueKey: APIClient.userId, firstName: "", lastName: "", mapString: "", mediaURL: "", latitude: 0, longitude: 0)
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    @IBAction func findLocationTapped(_ sender: Any) {
        setFindingLocation(true)
        studentInformation.mapString = locationTextField.text!
        studentInformation.mediaURL = linkTextField.text!
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTextField.text!, completionHandler: handleGeocodeAddressStringRequest(placemark:error:))
    }
    
    func handleGeocodeAddressStringRequest(placemark: [CLPlacemark]?, error: Error?) {
        if error == nil {
            if let placemark = placemark?.first {
                let coordinates = placemark.location!.coordinate
                studentInformation.latitude = coordinates.latitude
                studentInformation.longitude = coordinates.longitude
            }
            APIClient.getUserData(completion: handleUserDataRequest(userData:error:))
        } else {
            DispatchQueue.main.async {
                self.setFindingLocation(false)
                self.showFailureMessage(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func handleUserDataRequest(userData: UserData?, error: Error?) {
        self.setFindingLocation(false)
        if error == nil {
            studentInformation.firstName = userData!.firstName
            studentInformation.lastName = userData!.lastName
            self.performSegue(withIdentifier: "finish", sender: nil)
        } else {
            self.showFailureMessage(message: error?.localizedDescription ?? "")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finish" {
            let finishVC = segue.destination as! FinishViewController
            finishVC.studentInformation = studentInformation
        }
    }
    
    func setFindingLocation(_ findingLocation: Bool) {
        if findingLocation {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        locationTextField.isEnabled = !findingLocation
        linkTextField.isEnabled = !findingLocation
        findLocationButton.isEnabled = !findingLocation
    }
}
