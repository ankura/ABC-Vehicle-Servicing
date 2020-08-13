//
//  DummyData.swift
//  ABC Vehicle Servicing
//
//  Created by Ankur Agarwal on 12/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Class which will acts as data from service. Dummy data

import Foundation

class VehicleAPI {
 static func getVehicleData() -> [vehicleItem]{
   let vehicles = [
    vehicleItem(vehicleName: "Honda City Z", vehicleImage: "honda_car", vehicleKM: "14765 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_manual),
    vehicleItem(vehicleName: "Ford Ecospots", vehicleImage: "ecosports_car", vehicleKM: "4000 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Diesel", vehicleTrans: .vehicle_trans_automatic),
    vehicleItem(vehicleName: "Hyundai Creta", vehicleImage: "creta_car", vehicleKM: "10000 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_manual),
    vehicleItem(vehicleName: "Honda Brio", vehicleImage: "brio_car", vehicleKM: "36356 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_manual),
    vehicleItem(vehicleName: "Maruti Baleno", vehicleImage: "baleno_car", vehicleKM: "47122 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Diesel", vehicleTrans: .vehicle_trans_automatic),
    vehicleItem(vehicleName: "Honda Jazz", vehicleImage: "jazz_car", vehicleKM: "21133 / KM Driven", vehicleSeatCap: "4 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_manual),
    
    vehicleItem(vehicleName: "Hyundai Creta", vehicleImage: "creta_car", vehicleKM: "16050 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_automatic),
    vehicleItem(vehicleName: "Honda City Z", vehicleImage: "honda_car", vehicleKM: "4565 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Diesel", vehicleTrans: .vehicle_trans_automatic),
    vehicleItem(vehicleName: "Honda Brio", vehicleImage: "brio_car", vehicleKM: "16040 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Diesel", vehicleTrans: .vehicle_trans_manual),
    vehicleItem(vehicleName: "Honda Jazz", vehicleImage: "jazz_car", vehicleKM: "1133 / KM Driven", vehicleSeatCap: "4 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_manual),
    vehicleItem(vehicleName: "Ford Ecospots", vehicleImage: "ecosports_car", vehicleKM: "40000 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Petrol", vehicleTrans: .vehicle_trans_manual),
    vehicleItem(vehicleName: "Maruti Baleno", vehicleImage: "baleno_car", vehicleKM: "145322 / KM Driven", vehicleSeatCap: "5 Seater", vehicleFuel: "Diesel", vehicleTrans: .vehicle_trans_manual),
    
    ]
   return vehicles
  }
}


