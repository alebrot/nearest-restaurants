//
//  MKAnnotationView.swift
//  foursquare
//
//  Created by khlebtsov alexey on 21/06/16.
//  Copyright © 2016 khlebtsov alexey. All rights reserved.
//

import UIKit
import MapKit

extension MKAnnotationView {
    func highlight(){
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            var frame = self.frame;
            frame.origin.y = frame.origin.y + 3;
            self.frame = frame;
            }, completion: nil)

    }
}
