//
//  Helper.swift
//  O6U-Mobile-App
//
//  Created by Mohamed Ahmed on 1/1/20.
//  Copyright © 2020 Ahmed Ramzy. All rights reserved.
//

import SystemConfiguration
import UIKit


class Helper {
    
    class func checkConnection () -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    class func showInternetConnectionError(viewController: UIViewController){
            let alretController = UIAlertController(title: "Connection Error", message: "Please check your internet connection and retry again", preferredStyle: UIAlertController.Style.alert)
            alretController.addAction(UIAlertAction(title: "Rety", style: UIAlertAction.Style.default, handler: nil))
            viewController.present(alretController,animated: true, completion:nil)
    }
    
}
