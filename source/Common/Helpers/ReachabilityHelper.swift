//
//  ReachabilityHelper.swift
//
//
//  Created by sistemas on 10/12/18.
//  Copyright © 2018 Andres Paladines . All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

public class ReachabilityHelper {
    
    class func hasInternet() -> Bool {
        var email = sockaddr_in()
        email.sin_len = UInt8(MemoryLayout.size(ofValue: email))
        email.sin_family = sa_family_t(AF_INET)
        
        let defaultRuteAccess = withUnsafePointer(to: &email) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRuteAccess!, &flags) {
            return false
        }
        let isAccesible = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConexion = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isAccesible && !needsConexion)
    }
}
