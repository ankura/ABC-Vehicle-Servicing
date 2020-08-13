//
//  ServiceVehicleCell.swift
//  ABC Vehicle Servicing
//
//  Created by Ankur Agarwal on 11/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//   Class to create Service Vehicle cell

import UIKit

class ServiceVehicleCell: UITableViewCell {
    
    var vehicle:vehicleItem? {
        
        didSet {
            guard  let vehicleitem = vehicle  else {
                return
            }
            
            if let title = vehicleitem.vehicleName {
                vehicleTitleLabel.text = title
            }
            
            if let image = vehicleitem.vehicleImage {
                vehicleImageView.image = UIImage(named: image)
            }
            
            if let distance = vehicleitem.vehicleKM {
                vehicleKMLabel.text = distance
            }
            var otherDetails: String = ""
            if let capacity = vehicleitem.vehicleSeatCap {
                otherDetails = capacity
            }
            
            if let fuel = vehicleitem.vehicleFuel {
                if (!otherDetails.isEmpty) {
                    otherDetails += " - "
                }
                otherDetails += fuel
            }
            
            if let trans = vehicleitem.vehicleTrans {
                if (!otherDetails.isEmpty) {
                    otherDetails += " - "
                }
                switch trans {
                case .vehicle_trans_automatic:
                    otherDetails += "Automatic"
                    break
                case .vehicle_trans_manual:
                    otherDetails += "Manual"
                    break
                }
            }
            
            if (!otherDetails.isEmpty) {
                vehicleOtherLabel.text = otherDetails
            }
        }
    }
    
    private let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    private let vehicleImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        return img
    }()
    
    private let vehicleTitleLabel:UILabel = {
        let label = UILabel()
        var size: CGFloat = 18.0
        /*if(!Common.isPhone()) {
            size = Common.dynamicFontSize(15)
        }*/
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vehicleKMLabel:UILabel = {
        let label = UILabel()
        var size: CGFloat = 15.0
        /*if(!Common.isPhone()) {
            size = Common.dynamicFontSize(12)
        }*/
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vehicleOtherLabel:UILabel = {
        let label = UILabel()
        var size: CGFloat = 12.0
        /*if(!Common.isPhone()) {
            size = Common.dynamicFontSize(9)
        }*/
        label.font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.containerView.backgroundColor = .clear
        self.contentView.addSubview(vehicleImageView)
        containerView.addSubview(vehicleTitleLabel)
        containerView.addSubview(vehicleKMLabel)
        containerView.addSubview(vehicleOtherLabel)
        self.contentView.addSubview(containerView)
        self.accessoryType = .disclosureIndicator
        

        vehicleImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        vehicleImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        vehicleImageView.widthAnchor.constraint(equalToConstant:150).isActive = true
        vehicleImageView.heightAnchor.constraint(equalToConstant:112).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.vehicleImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        vehicleTitleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 15 ).isActive = true
        vehicleTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        vehicleTitleLabel.widthAnchor.constraint(equalTo:self.containerView.widthAnchor).isActive = true
        
        vehicleKMLabel.topAnchor.constraint(equalTo:self.vehicleTitleLabel.bottomAnchor, constant: 5).isActive = true
        vehicleKMLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        vehicleKMLabel.widthAnchor.constraint(equalTo:self.containerView.widthAnchor).isActive = true
        
        vehicleOtherLabel.topAnchor.constraint(equalTo:self.vehicleKMLabel.bottomAnchor, constant: 14).isActive = true
        vehicleOtherLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        vehicleOtherLabel.widthAnchor.constraint(equalTo:self.containerView.widthAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}


// TableView Cell to show activity indecator
class ActivityIndicatorCell: UITableViewCell {
    
    let activityIndecator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(activityIndecator)
        
        activityIndecator.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        activityIndecator.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}


