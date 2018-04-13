//  Created by Michal Ciurus

import UIKit
import SharedTools
import NetworkAPI

class CreateBoxRouter: Routable {
    
    var didFinishRouting = EventObservable<Void>()
    var didCreateBox = EventObservable<BoxDocument>()
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createBoxVc = CreateBoxViewController()
        
        createBoxVc.interactor.didCreateBox.observe { [weak self] box in
            self?.didCreateBox.fireEvent(with: box)
            self?.navigationController.popViewController(animated: true)
            self?.didFinishRouting.fireEvent()
        }
        
        navigationController.pushViewController(createBoxVc, animated: true)
    }
}
