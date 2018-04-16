//  Created by Michal Ciurus

import Alamofire
import SharedTools

public enum Result<T> {
    case success(T)
    case error
}

public protocol BoxAPIProtocol {
    
    func getBoxes(page: Int, completion: @escaping (Result<[BoxDocument]?>)-> Void)
    func createBox(key: String, scope: Scope, completion: @escaping (Result<BoxDocument>) -> Void)
    func deleteBox(identifier: Int, completion: @escaping (Result<()>) -> Void)
    func login()
    
}

final public class BoxAPI: BoxAPIProtocol {
    
    public init() { }
    
    /// Fetches a list of boxes from the server
    ///
    /// - Parameters:
    ///   - page: which page to fetch
    ///   - completion: result
    public func getBoxes(page: Int, completion: @escaping (Result<[BoxDocument]?>) -> Void){
        Alamofire.request(BoxAPIRoute.getBoxes(page)).responseJSON { response in
            
            guard response.error == nil else {
                completion(.error)
                return
            }
            
            let decoder = JSONDecoder.boxDecoder()
            if let data = response.data, let boxesResponse = try? decoder.decode(BoxesResponse.self, from: data) {
                completion(.success(boxesResponse.data))
            } else {
                completion(.error)
            }
        }
    }
    
    
    /// Creates a box on the server
    ///
    /// - Parameters:
    ///   - key: key of the box
    ///   - scope: scope of the box
    ///   - completion: result
    public func createBox(key: String, scope: Scope, completion: @escaping (Result<BoxDocument>) -> Void) {
        var boxDocument = BoxDocument()
        boxDocument.key = key
        boxDocument.scope = scope
        Alamofire.request(BoxAPIRoute.createBox(boxDocument)).response { (response) in
            guard response.error == nil else {
                completion(.error)
                return
            }
            
            // TODO:
            // Real API would return created box document
            // Simulating that to be able to add the document to the boxes list
            boxDocument.updatedAt = Date()
            boxDocument.productId = UUID().hashValue
            
            return completion(.success(boxDocument))
        }
    }
    
    
    /// Deletes a box on the server
    ///
    /// - Parameters:
    ///   - identifier: id of the box
    ///   - completion: result
    public func deleteBox(identifier: Int, completion: @escaping (Result<()>) -> Void) {
        Alamofire.request(BoxAPIRoute.delete(identifier)).response { (response) in
            guard response.error == nil else {
                completion(.error)
                return
            }
            
            return completion(.success(()))
        }
    }
    
    public func login() {
        //TODO: Implement login/registration
        KeychainAccess.save(accessToken: "123myaccesstoken")
    }
    
}
