//
//  BaseViewController.swift
//  ParticleBox
//
//  Created by Michal Ciurus on 13/04/2018.
//  Copyright © 2018 michalciurus. All rights reserved.
//

import UIKit
import SharedTools

extension UIViewController {
    func subscribeTo(errorEmitter: EmitsError) {
        errorEmitter.errorEvent.observe { [weak self] (error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertOk)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
