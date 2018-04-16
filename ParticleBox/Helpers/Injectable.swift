//  Created by Michal Ciurus

import Foundation

/// For classes where interactor needs to be injected through variable injection
/// Storyboard instantiated ViewControllers are a great example
protocol InjectableInteractor {
    
    associatedtype T
    var interactor: T! { get set }
    func inject(_ interactor: T)
    func assertDependency()
    
}

extension InjectableInteractor {
    
    func assertDependency() {
        assert(interactor != nil)
    }
    
    mutating func inject(_ interactor: T) {
        self.interactor = interactor
    }
    
}
