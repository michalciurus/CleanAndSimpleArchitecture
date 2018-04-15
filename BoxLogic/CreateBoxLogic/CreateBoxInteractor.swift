//  Created by Michal Ciurus

import NetworkAPI
import SharedTools

public class CreateBoxInteractor {
    
    //MARK: Public Properties
    
    public let presenter = CreateBoxPresenter()
    public let didCreateBox = EventObservable<BoxDocument>()
    
    //MARK: Public Methods
    
    public init() { }
    
    public func createBox(key: String, scope: Int) {
        
        presenter.isCreating.value = true
        
        var scopeEnum = Scope.device
        switch scope {
        case 0: scopeEnum = Scope.device
        case 1: scopeEnum = Scope.user
        case 2: scopeEnum = Scope.product
        default: fatalError("Scope not supported")

        }
        
        BoxAPI.shared.createBox(key: key, scope: scopeEnum) { [weak self] result in
            self?.presenter.isCreating.value = false
            switch result {
            case .success(let box):
                self?.didCreateBox.fireEvent(with: box)
                return
            case .error:
                self?.presenter.errorEvent.fireEvent(with: "Can't create box")
            }
        }
    }
}
