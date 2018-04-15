//  Created by Michal Ciurus

import UIKit
import SharedTools

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let routerCollection = RouterCollection()
    var appRouter: AppRouter!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        appRouter = AppRouter(window: self.window!)
        routerCollection.add(router: appRouter)
        appRouter.start()
        
        return true
    }
    
}

