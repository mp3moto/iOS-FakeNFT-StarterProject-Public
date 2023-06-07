import Foundation

protocol NFTModelProtocol {
    func getNFT(id: Int, completion: @escaping (Result<[NFTItem], Error>) -> Void)
}

final class NFTModel: NFTModelProtocol {
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getNFT(id: Int, completion: @escaping (Result<[NFTItem], Error>) -> Void) {
        guard let url = URL(string: "https://64611c69491f9402f49ecce1.mockapi.io/api/v1/nft/\(id)")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: [NFTItem].self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
