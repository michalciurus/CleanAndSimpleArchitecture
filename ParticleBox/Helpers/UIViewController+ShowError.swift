//  Created by Michal Ciurus

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
