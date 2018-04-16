//  Created by Michal Ciurus

import Alamofire
import SharedTools

enum BoxAPIRoute: URLRequestConvertible {
        
    static var accessToken: String? = {
        return KeychainAccess.loadAccessToken()
    }()
    
    case getBoxes(Int)
    case createBox(BoxDocument)
    case delete(Int)
    
    var method: HTTPMethod {
        switch self {
        case .getBoxes: return .get
        case .createBox: return .post
        case .delete: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getBoxes, .createBox: return "/box"
        case .delete(let identifier): return "/box/\(identifier)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getBoxes(let page):
            urlRequest = try URLEncoding.default.encode(urlRequest, with:
                ["per_page" : NetworkConstants.itemsPerPage, "page" : page])
        case .createBox(let box):
            let encoder = JSONEncoder.boxEncoder()
            let encodedBox = try encoder.encode(box)
            urlRequest.httpBody = encodedBox
        case .delete: break
        }
        
        guard let token = BoxAPIRoute.accessToken else { fatalError("Access token missing, login first") }
        
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
    }
    
}
