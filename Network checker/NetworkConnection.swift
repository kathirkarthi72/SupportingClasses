//
//  NetworkConnection.swift
//  Network
//
//  Created by Kathiresan  on 04/04/19.
//  Copyright © 2019 Kathiresan. All rights reserved.
//

import Foundation
import Network

/// Network connection
class NetworkConnection {
    
    /// Dispatch queue
   private var queue = DispatchQueue(label: "Monitor", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    
    /// Network connection monitor. It will automatically notify when ever you connection was update.
    ///
    /// - Parameter isConnected: isConnected to internet or not.
    func networkMonitor(isConnected: @escaping((_ state: Bool,_ interfare: String?) -> ())) {
        
        let pathMonitor = NWPathMonitor(requiredInterfaceType: .wifi)
        
        pathMonitor.pathUpdateHandler = { path in
            
            if path.status == NWPath.Status.satisfied {
                
                if path.usesInterfaceType(.wifi) {
                    isConnected(true, "WiFi")
                } else if path.usesInterfaceType(.cellular) {
                    isConnected(true, "cellular")
                } else if path.usesInterfaceType(.wiredEthernet) {
                    isConnected(true, "wiredEthernet")
                } else {
                    isConnected(true, "others")
                }
            } else {
                isConnected(false, nil)
            }
            print("is Cellular data: \(path.isExpensive)") //Checking is this is a Cellular data
        }
        pathMonitor.start(queue: queue)
    }
}
