import Foundation

final class CatalogModel: CatalogModelProtocol {
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard //let networkClient = networkClient,
              let url = URL(string: url)
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: T.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNFTCollections(completion: @escaping (Result<[NFTCollection], Error>) -> Void) {
        guard //let networkClient = networkClient,
              let url = URL(string: "\(Config.baseUrl)/collections")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: [NFTCollection].self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
