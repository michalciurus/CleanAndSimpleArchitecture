//  Created by Michal Ciurus

import Foundation
import NetworkAPI

let mockDocument: BoxDocument = {
    var document = BoxDocument()
    document.key = "temperature"
    document.scope = Scope.device
    document.productId = 123
    document.updatedAt = Date()
    return document
}()

class BoxAPIMock: BoxAPIProtocol {
    
    func login() {
        
    }
    
    static var shared: BoxAPIProtocol = BoxAPIMock()
    
    var calledGetBoxes = false
    var calledCreateBox = false
    var didCallDelete = false
    var lastPage = 0
    
    func createBox(key: String, scope: Scope, completion: @escaping (Result<BoxDocument>) -> Void) {
        calledCreateBox = true
        completion(.success(mockDocument))
    }
    
    func getBoxes(page: Int, completion: @escaping (Result<[BoxDocument]?>) -> Void) {
        calledGetBoxes = true
        completion(.success([mockDocument]))
        lastPage = page
    }
    
    func deleteBox(identifier: Int, completion: @escaping (Result<()>) -> Void) {
        didCallDelete = true
        completion(.success(()))
    }
}
