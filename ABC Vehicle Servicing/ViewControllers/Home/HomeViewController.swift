//
//  HomeViewController.swift
//  ABC Vehicle Servicing
//
//  Created by Ankur Agarwal on 09/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Main/Home view controller

import Foundation
import UIKit
import SwiftyJSON
import Toast_Swift
import Alamofire


enum cellIdentifiers {
  static let serviceVehicleCell = "ServiceVehicleCell"
  static let serviceActivityCell = "ActivityIndicatorCell"
}

protocol VehicleSelectionDelegate: class {
  func vehicleSelected(_ vehicle: vehicleItem)
}

class HomeViewController: UIViewController, UIGestureRecognizerDelegate, SidePanelViewControllerDelegate, UITableViewDataSource, UITableViewDelegate  {
    
    // add shadown on controller if slide pannel is open
    var currentState: slideOutState = .collapsed {
       didSet {
         let shouldShowShadow = currentState != .collapsed
         showShadowForCenterViewController(shouldShowShadow)
       }
     }
    
    var leftViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60 // How much panel should expand
    
    @IBOutlet var tableView : UITableView!
    private var refreshControl = UIRefreshControl()
    weak var delegate: VehicleSelectionDelegate?
    
    /// array to draw table
    var vehicleItems: Array<vehicleItem> = []
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        //self.navigationItem.title = "Home"
        
        // Create left button for navigation item
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: LocalizationKey.img_menu.string), style: .plain, target: self, action: #selector(menuButtonClicked))
        
        // Create  buttons for the navigation item.
        self.navigationItem.leftBarButtonItem = leftButton
        
        // Create right button for navigation item
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: LocalizationKey.img_notification.string), style: .plain, target: self, action: #selector(notificationButtonClicked))
        
        // Create  buttons for the navigation item.
        self.navigationItem.rightBarButtonItem = rightButton
        
        /*let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)*/
        
        addUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        drawUI()
    }
    
    /// Method to add tableview on view controller
    private func addListTable()  {
        
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .darkGray
        
        // refresh control to refresh the data
        refreshControl.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        
        tableView.addSubview(self.refreshControl)
        //@@self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ServiceVehicleCell.self, forCellReuseIdentifier: cellIdentifiers.serviceVehicleCell)
        tableView.register(ActivityIndicatorCell.self, forCellReuseIdentifier: cellIdentifiers.serviceActivityCell)
        tableView.tableFooterView = UIView() // remove empty last cell
        
        
        getVehicleData()
    }
    
    // Method to add various UI component on View/Scroll View
    func addUI() {
        
        addListTable()
    }
    
    
    // Method to draw UI on screen based on device type and orientation
    func drawUI() {
        
    }
    
    
    /// Method to handle click on menu button (left navigation)
    @objc private func menuButtonClicked() {
        
        let notAlreadyExpanded = (self.currentState != .leftPanelExpanded)
        if notAlreadyExpanded {
            self.addLeftPanelViewController()
        }
        self.animateLeftPanel(shouldExpand: notAlreadyExpanded)
        
    }
    
    
    /// Method to handle click on notification button (right navigation)
    // as of now it is behaving as logout button
    @objc private func notificationButtonClicked() {
        
        self.showAlert(title: LocalizationKey.alert_title_confirmation.string, message: LocalizationKey.logout_conf_str.string, actionTitle: LocalizationKey.alert_yes.string, secondTitle: LocalizationKey.alert_no.string, completion: { (success,val) -> Void in
            if success {
                if(val == 0) { // yes, go back
                    
                    Common.logOutResetValue()
                    let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginViewController
                    UIApplication.shared.windows.first?.rootViewController = loginVC
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                } else if (val == 1) { // no
                   // do if anything is required
                }
            }})
    }
    
    
    // Method to reload table
    @objc func reloadData() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    // Method to get the Vehicle data
    func getVehicleData() {
        vehicleItems = VehicleAPI.getVehicleData()
        tableView.reloadData()
    }
    
    // Method to get more vehicle data
    func getMoreVehicleData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                // Download more data here
                DispatchQueue.main.async {
                    self.vehicleItems += VehicleAPI.getVehicleData()
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    // Method to handle scroll on UITabelview, get data if it reaches bottom
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
            getMoreVehicleData()
        }
    }
    
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 80
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 80))
            headerView.backgroundColor = .white
            
            var xPos: CGFloat = 30.0
            var yPos: CGFloat = 0.0
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            let image = UIImage(named: "profile")
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = image!.size.width/2
            imageView.layer.masksToBounds = true
            
            yPos = (headerView.frame.height-image!.size.height)/2
            imageView.frame = CGRect(x: xPos, y: yPos, width: image!.size.width, height: image!.size.height)
            headerView.addSubview(imageView)
            
            xPos += (image!.size.width + 10)
            
            let name = UILabel.init(frame: CGRect.init(x: xPos, y: yPos, width: headerView.frame.width, height: 30))
            name.text = Preferences.FullNameValue()
            name.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
            name.textColor = kBrandColor
            name.backgroundColor = .clear
            name.textAlignment = .left
            headerView.addSubview(name)
            
            yPos += 20
            let email = UILabel()
            email.text = Preferences.userIdValue()
            email.frame = CGRect(x: xPos, y: yPos, width: headerView.frame.width, height: 30)
            email.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.semibold)
            email.textColor = .lightGray
            email.textAlignment = .left
            headerView.addSubview(email)
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVehicle = vehicleItems[indexPath.row]
        delegate?.vehicleSelected(selectedVehicle)
        
        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - 
    
    // MARK: - Table View Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //Return the amount of items
            return vehicleItems.count
        } else if section == 1 {
            //Return the Loading cell
            return 1
        } else {
            //Return nothing
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers.serviceVehicleCell, for: indexPath as IndexPath) as! ServiceVehicleCell
            cell.backgroundColor = .clear
            
            cell.vehicle = vehicleItems[indexPath.row]
            
            cell.separatorInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            cell.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 100.0, bottom: 0.0, right: 0.0)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers.serviceActivityCell, for: indexPath) as! ActivityIndicatorCell
            cell.backgroundColor = .clear
            cell.activityIndecator.startAnimating()
            
            cell.separatorInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            cell.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 100.0, bottom: 0.0, right: 0.0)
            return cell
        }
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 100 //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }
    
    // MARK: -
    
    
    
    // MARK: - Implementation for sliding view
    
    /// Method which notifies the container that the size of its view is about to change.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
                self.drawUI()
        })
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    
    // Method to add left panel
    func addLeftPanelViewController() {
        /*guard leftViewController == nil else { return }

      if let vc = self.leftSidePanelViewController() {
        vc.menuItems = MenuItem.allMenuItems()
        addChildSidePanelController(vc)
        leftViewController = vc
      }*/
    }
    
    
    // Method to animate left panel
    func animateLeftPanel(shouldExpand: Bool) {
      if shouldExpand {
        currentState = .leftPanelExpanded
        animateCenterPanelXPosition(
            targetPosition: self.view.frame.width - centerPanelExpandedOffset)
      } else {
        animateCenterPanelXPosition(targetPosition: 0) { _ in
            self.currentState = .collapsed
          self.leftViewController?.view.removeFromSuperview()
          self.leftViewController = nil
        }
      }
    }
    
    
    // Method to animate
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseInOut, animations: {
                       //self.centerNavigationController.view.frame.origin.x = targetPosition
                        self.view.frame.origin.x = targetPosition
      }, completion: completion)
    }
    
    
    // Method to show opacity when side menu is open
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
      if shouldShowShadow {
        self.view.layer.shadowOpacity = 0.8
      } else {
        self.view.layer.shadowOpacity = 0.0
      }
    }
    
    // Method to add child side panel
    func addChildSidePanelController(_ sidePanelController: SidePanelViewController) {
      /*sidePanelController.delegate = self
      view.insertSubview(sidePanelController.view, at: 0)
      addChild(sidePanelController)
      sidePanelController.didMove(toParent: self)*/
    }
    
    
    func leftSidePanelViewController() -> SidePanelViewController? {
        return self.storyboard?.instantiateViewController(withIdentifier: "SideVC")as? SidePanelViewController
    }
    
    // MARK:- Gesture recognizer
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
        case .began:
            if currentState == .collapsed {
                if gestureIsDraggingFromLeftToRight {
                    addLeftPanelViewController()
                    showShadowForCenterViewController(true)
                }
                
            }
            
        case .changed:
            if gestureIsDraggingFromLeftToRight || currentState == .leftPanelExpanded {
            if let rview = recognizer.view {
                rview.center.x = rview.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
                }
            }
            
        case .ended:
            if let _ = leftViewController,
                let rview = recognizer.view {
                // animate the side panel open or closed based on whether the view
                // has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
            
        default:
            break
        }
    }
    
    // MARK:- SidePanelViewControllerDelegate delegate Method
    func didSelectMenuItem(_ item: MenuItem) {
           //
       }
    
    // MARK:-
    
    // MARK: -
    
}
