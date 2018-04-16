//  Created by Michal Ciurus

import Foundation

public protocol Routable: class {
    
    var didFinishRouting: EventObservable<Void> { get }
    func start()
    
}
