//  Created by Michal Ciurus

import UIKit
import SharedTools
import NetworkAPI

class AppRouter: Routable {
    var didFinishRouting = EventObservable<Void>()
    var window: UIWindow
    let navigationController = UINavigationController()
    let routerCollection = RouterCollection()
    var boxFeed: BoxFeedViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        BoxAPI.shared.login()
        
        let boxFeedStoryboard = UIStoryboard(name: "BoxFeed", bundle: nil)
        guard let boxFeedViewController = boxFeedStoryboard.instantiateViewController(withIdentifier: "BoxFeedViewController") as? BoxFeedViewController else {
            fatalError("Can't load main feed view controller")
        }
        
        boxFeedViewController.createBoxEvent.observe { [weak self] _ in
            self?.showCreateBox()
        }
        
        navigationController.pushViewController(boxFeedViewController, animated: false)
        window.rootViewController = navigationController
        
        self.boxFeed = boxFeedViewController
    }
    
}

private extension AppRouter {
    func showCreateBox() {
        let createBoxRouter = CreateBoxRouter(navigationController: self.navigationController)
        
        createBoxRouter.didCreateBox.observe { [weak self] box in
            if let box = box {
                self?.boxFeed?.interactor.add(box: box)
            }
        }
        
        self.routerCollection.add(router: createBoxRouter)
        createBoxRouter.start()
    }
}
