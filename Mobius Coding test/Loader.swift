//
//  Loader.swift
//  Mobius Coding test
//
//  Created by Adaps on 09/12/20.
//  Copyright © 2020 Task. All rights reserved.
//

import Foundation
import MBProgressHUD

///---------------------------------------------------------
/// MARK: - loader Creation Functionality
///---------------------------------------------------------

class Loader {
    
    static func showAdded(to view: UIView, animated: Bool){
        MBProgressHUD.showAdded(to: view, animated: animated)
    }
    
    static func hide(for view: UIView, animated: Bool){
        MBProgressHUD.hide(for: view, animated: animated)
    }
}

extension UIViewController {
    
    func showLoader(animated: Bool = false) {
        Loader.showAdded(to: self.view, animated: animated)
    }
    
    func hideLoader(animated: Bool = false) {
        Loader.hide(for: self.view, animated: animated)
    }
}

