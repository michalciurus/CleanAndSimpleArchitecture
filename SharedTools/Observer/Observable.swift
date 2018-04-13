//  Created by Michal Ciurus

import Foundation

public class Observable<T> {
    
    public typealias ObserverClosure = (T?) -> ()
    
    var observers: [ObserverClosure] = []
    
    public init() { }

    public func observe(_ closure: @escaping ObserverClosure) {
        observers.append(closure)
    }
}
