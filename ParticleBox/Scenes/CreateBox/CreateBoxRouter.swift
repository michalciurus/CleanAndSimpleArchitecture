//  Created by Michal Ciurus

import UIKit
import SharedTools
import NetworkAPI

final class CreateBoxRouter: Routable {
    
    //MARK: Private Properties
    
    private let navigationController: UINavigationController

    //MARK: Public Properties
    
    var didFinishRouting = EventObservable<Void>()
    var didCreateBox = EventObservable<BoxDocument>()
    
    //MARK: Public Methods
    
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
