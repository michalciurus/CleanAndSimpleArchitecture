//  Created by Michal Ciurus

import Alamofire

public enum Result<T> {
    case success(T)
    case error
}

public protocol BoxAPIProtocol {
    static var shared: BoxAPIProtocol { get }
    func getBoxes(page: Int, completion: @escaping (Result<[BoxDocument]?>) -> ())
    func createBox(key: String, scope: Scope, completion: @escaping (Result<BoxDocument>) -> ())
    func deleteBox(identifier: Int, completion: @escaping (Result<()>) -> ())
}

public class BoxAPI: BoxAPIProtocol {
    public static var shared: BoxAPIProtocol = BoxAPI()
    
    private init() { }
    
    public func getBoxes(page: Int, completion: @escaping (Result<[BoxDocument]?>) -> ()){
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
    
    public func createBox(key: String, scope: Scope, completion: @escaping (Result<BoxDocument>) -> ()) {
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
    
    public func deleteBox(identifier: Int, completion: @escaping (Result<()>) -> ()) {
        Alamofire.request(BoxAPIRoute.delete(identifier)).response { (response) in
            guard response.error == nil else {
                completion(.error)
                return
            }
            
            return completion(.success(()))
        }
    }
    
}
