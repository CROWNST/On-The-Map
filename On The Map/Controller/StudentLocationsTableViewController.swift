//
//  TableViewController.swift
//  On The Map
//
//  Created by David Hsieh on 8/5/21.
//

import UIKit

class StudentLocationsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        APIClient.getStudentLocations(completion: handleGetStudentLocations(studentLocations:error:))
    }
    
    func handleGetStudentLocations(studentLocations: [StudentInformation], error: Error?) {
        if error == nil {
            StudentInformationModel.studentInformationList = studentLocations
            self.tableView.reloadData()
        } else {
            self.showFailureMessage(message: error?.localizedDescription ?? "")
        }
    }
}

extension StudentLocationsTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        StudentInformationModel.studentInformationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentLocationCell")!
        
        let studentLocation = StudentInformationModel.studentInformationList[indexPath.row]
        
        cell.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentInformation = StudentInformationModel.studentInformationList[indexPath.row]
        let app = UIApplication.shared
        app.open(URL(string: studentInformation.mediaURL)!, options: [:], completionHandler: nil)
    }
}
