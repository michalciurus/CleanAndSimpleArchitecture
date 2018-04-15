//  Created by Michal Ciurus

import UIKit
import SharedTools
import NetworkAPI
import BoxLogic

final class CreateBoxRouter: Routable {
    
    //MARK: Private Properties
    
    private let navigationController: UINavigationController
    private let boxAPI: BoxAPI

    //MARK: Public Properties
    
    var didFinishRouting = EventObservable<Void>()
    var didCreateBox = EventObservable<BoxDocument>()
    
    //MARK: Public Methods
    
    init(navigationController: UINavigationController, boxAPI: BoxAPI) {
        self.navigationController = navigationController
        self.boxAPI = boxAPI
    }
    
    func start() {
        let createBoxVc = CreateBoxViewController(interactor: CreateBoxInteractor(boxAPI: boxAPI))

        createBoxVc.interactor.didCreateBox.observe { [weak self] box in
            self?.didCreateBox.fireEvent(with: box)
            self?.navigationController.popViewController(animated: true)
            self?.didFinishRouting.fireEvent()
        }
        
        navigationController.pushViewController(createBoxVc, animated: true)
    }
}
