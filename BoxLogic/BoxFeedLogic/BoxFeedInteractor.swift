// Created by Michal Ciurus

import Foundation
import NetworkAPI

public class BoxFeedInteractor {
    
    //MARK: Private Properties
    
    private let boxAPI: BoxAPIProtocol
    private var currentPage: Int = 0
    
    //MARK: Public Properties
    
    public let presenter = BoxFeedPresenter()

    //MARK: Public Methods
    
    public init(boxAPI: BoxAPIProtocol) {
        self.boxAPI = boxAPI
    }
    
    public func fetchInitialBoxes() {
        presenter.isLoading.value = true
        boxAPI.getBoxes(page: 0) { [weak self] result in
            self?.presenter.isLoading.value = false
            switch result {
            case .success(let boxes):
                self?.currentPage = 0
                self?.presenter.removeAllBoxes()
                if let fetchedBoxes = boxes {
                    self?.presenter.add(boxes: fetchedBoxes)
                }
            case .error:
                self?.presenter.errorEvent.fireEvent(with: "Can't fetch initial boxes")
            }
        }
    }
    
    public func fetchMoreBoxes() {
        presenter.isLoading.value = true
        boxAPI.getBoxes(page: currentPage + 1) { [weak self] result in
            self?.presenter.isLoading.value = false
            switch result {
            case .success(let boxes):
                self?.currentPage += 1
                if let newBoxes = boxes {
                    self?.presenter.add(boxes: newBoxes)
                }
            case .error:
                self?.presenter.errorEvent.fireEvent(with: "Can't fetch more boxes")
            }
        }
    }
    
    public func deleteBox(at index: Int, completion: @escaping (Bool) -> Void) {
        guard let boxId = presenter.boxes.value?[index].identifier else { fatalError("Presenter missing")}
        
        boxAPI.deleteBox(identifier: boxId) { [weak self] result in
            switch result {
            case .error:
                self?.presenter.errorEvent.fireEvent(with: "Can't delete box")
                completion(false)
            default: break
            }
            
            self?.presenter.deleteBox(at: index)
            completion(true)
        }
    }
    
    public func add(box: BoxDocument) {
        presenter.add(boxes: [box], atTheTop: true)
    }
    
}
