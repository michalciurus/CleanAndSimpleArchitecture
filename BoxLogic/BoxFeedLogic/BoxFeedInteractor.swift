// Created by Michal Ciurus
import Foundation
import NetworkAPI

public class BoxFeedInteractor {
    
    public let presenter = BoxFeedPresenter()
    private let boxAPI: BoxAPIProtocol
    private var currentPage: Int = 0
    
    public init(boxAPI: BoxAPIProtocol = BoxAPI.shared) {
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
                return
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
                return
            }
        }
    }
    
    public func deleteBox(at index: Int) {
        let boxId = presenter.boxes.value![index].identifier
        
        boxAPI.deleteBox(identifier: boxId) { [weak self] result in
            switch result {
            case .error:
                return
            default: break
            }
            
            self?.presenter.deleteBox(at: index)
        }
    }
    
    public func add(box: BoxDocument) {
        presenter.add(boxes: [box], atTheTop: true)
    }
}
