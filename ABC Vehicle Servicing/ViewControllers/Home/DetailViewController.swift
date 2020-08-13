//
//  DetailViewController.swift
//  ABC Vehicle Servicing
//
//  Created by Ankur Agarwal on 12/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//

import Foundation
import UIKit

let DETAIL_TEXTVIEW_TAG = 1005

class DetailViewController: UIViewController {
    
    var selectedVehicle: vehicleItem?
    
    private let vehicleStatusLabel : UILabel = {
        // Vehicle Status Me label
        let label = UILabel()
        label.text = LocalizationKey.vehicle_status_str.string
        label.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(18), weight: UIFont.Weight.semibold)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updateStatusView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = LocalizationKey.update_status_str.string
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
        label.textColor = .black
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = UIColor.gray
        textView.tag = DETAIL_TEXTVIEW_TAG
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true

        return view
    }()
    
    
    private let updateStatusButton: UIButton = {
       
        let updateButton = UIButton()
        updateButton.backgroundColor = .clear
        let btnImage = UIImage(named: LocalizationKey.img_updates_status.string)
        updateButton.setBackgroundImage(btnImage, for: .normal)
        updateButton.imageView?.contentMode = .scaleAspectFit
        updateButton.frame = CGRect(x: 0, y: 0, width: btnImage!.size.width, height: btnImage!.size.height)
        updateButton.addTarget(self, action: #selector(updateStatusTapped), for: UIControl.Event.touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        
        return updateButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kCustomGreyColor
        self.navigationItem.title = selectedVehicle?.vehicleName
        
        addUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleKeyboard(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
            drawUI()
    }
    
    
    // Method to add various UI component on View/Scroll View
    func addUI() {
        
        self.view.addSubview(self.vehicleStatusLabel)
        
        self.view.addSubview(self.updateStatusView)
        
        self.view.addSubview(self.updateStatusButton)
    }
    
    
    // Method to draw UI on screen based on device type and orientation
    func drawUI() {
        
        var val: CGFloat = 0.0
        
        if(!Common.isPhone() ) {
            val = 40
        }
        
        let guide = self.view.safeAreaLayoutGuide
        
        self.vehicleStatusLabel.removeConstraints(self.vehicleStatusLabel.constraints)
        vehicleStatusLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40+val).isActive = true
        vehicleStatusLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        vehicleStatusLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 10).isActive = true
        vehicleStatusLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        updateStatusView.topAnchor.constraint(equalTo: self.vehicleStatusLabel.bottomAnchor, constant: 20).isActive = true
        updateStatusView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        updateStatusView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        updateStatusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        updateStatusView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.updateStatusButton.removeConstraints(self.updateStatusButton.constraints)
        updateStatusButton.topAnchor.constraint(equalTo: self.updateStatusView.bottomAnchor, constant: 30).isActive = true
        updateStatusButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        updateStatusButton.widthAnchor.constraint(equalToConstant: updateStatusButton.currentBackgroundImage!.size.width).isActive = true
        updateStatusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    /// Method to handle the keyboard. This will dismiss the keyboard if open if clicked outside the update status area
    @objc func handleKeyboard(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.view)
       
       if !updateStatusView.bounds.contains(location) {
        self.view.endEditing(true)
       }
    }
    
    /// Method to clear the text of text field inside the update status
    func clearText() {
        let textView = self.updateStatusView.viewWithTag(DETAIL_TEXTVIEW_TAG) as? UITextView
        if(textView != nil) {
            textView!.text = ""
        }
    }
    
    /// Method to return the text of text field inside the update status
    func getText() -> String {
        let textView = self.updateStatusView.viewWithTag(DETAIL_TEXTVIEW_TAG) as? UITextView
        if(textView != nil) {
            return textView!.text
        } else {
            return ""
        }
    }
    
    
    /// Method which notifies the container that the size of its view is about to change.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

         coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

         }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                 //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
                 self.drawUI()
         })
         super.viewWillTransition(to: size, with: coordinator)
     }
    
    
    // TODO: - Implement update status with service
    // Method when user click on update Status button
    @objc func updateStatusTapped() {
        Common.LogDebug("Update Status Tappped")
        self.view.endEditing(true)
        var msg = ""
        if(!getText().isEmpty) {
            self.clearText()
            msg = LocalizationKey.update_msg_str.string
        } else {
            msg = LocalizationKey.status_empty_str.string
        }
        self.showAlert(title: LocalizationKey.alert_title_success.string, message: msg, actionTitle: LocalizationKey.alert_ok.string)
    }
    // TODO: -
    
}

extension DetailViewController: VehicleSelectionDelegate {
    func vehicleSelected(_ vehicle: vehicleItem) {
        selectedVehicle = vehicle
        self.navigationItem.title = selectedVehicle?.vehicleName
  }
}
