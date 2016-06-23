//
//  UIViewController.swift
//  foursquare
//
//  Created by khlebtsov alexey on 15/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import UIKit

extension UIViewController {
    func performOnMainThread(block: ()->Void){
        dispatch_async(dispatch_get_main_queue(), {
            block()
        })
    }
}
