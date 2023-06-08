import Foundation

final class CollectionModel: CollectionModelProtocol {
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: url)
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
    
    func getNFTCollectionInfo(id: Int, completion: @escaping (Result<NFTCollection, Error>) -> Void) {
        guard let url = URL(string: "\(Config.baseUrl)/collections/\(id)")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: NFTCollection.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNFTCollectionAuthor(id: Int, completion: @escaping (Result<NFTCollectionAuthor, Error>) -> Void) {
        guard let url = URL(string: "\(Config.baseUrl)/users/\(id)")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: NFTCollectionAuthor.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllNFTs(completion: @escaping (Result<[NFTItem], Error>) -> Void) {
        guard let url = URL(string: "\(Config.baseUrl)/nft")
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
    
    func getLikedNFTs(completion: @escaping (Result<NFTLiked, Error>) -> Void) {
        guard let url = URL(string: "\(Config.baseUrl)/profile/1")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: User.self) { result in
            switch result {
            case .success(let data):
                completion(.success(NFTLiked(likes: data.likes)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "\(Config.baseUrl)/profile/1")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: User.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNFTsInCart(completion: @escaping (Result<NFTsInCart, Error>) -> Void) {
        guard let url = URL(string: "\(Config.baseUrl)/orders/1")
        else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1)))
            return
        }
        let request = AnyRequest(endpoint: url)
        networkClient.send(request: request, type: NFTsInCart.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func toggleNFTItemInCart(id: Int, completion: @escaping (Result<Order, Error>) -> Void) {
        getNFTsInCart { [weak self] result in
            switch result {
            case .success(let data):
                if data.nfts.filter({ $0 == id }).count == 0 {
                    var newOrderContent = data.nfts
                    newOrderContent.append(id)
                    let newOrder = Order(nfts: newOrderContent, id: "1")
                    self?.networkClient.send(request: UpdateOrderRequest(order: newOrder), type: Order.self) { result in
                        switch result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    self?.networkClient.send(request: UpdateOrderRequest(order: Order(nfts: data.nfts.filter({ $0 != id }), id: "1")), type: Order.self) { result in
                        switch result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func toggleNFTLikeInProfile(id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        getUser { [weak self] result in
            switch result {
            case .success(let data):
                if data.likes.filter({ $0 == id }).count == 0 {
                    var newProfileLikesContent = data.likes
                    newProfileLikesContent.append(id)
                    let newProfile = User(avatar: data.avatar, name: data.name, description: data.description, website: data.website, nfts: data.nfts, likes: newProfileLikesContent, id: data.id)
                    self?.networkClient.send(request: UpdateProfileRequest(profile: newProfile), type: User.self) { result in
                        switch result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                } else {
                    let newProfile = User(avatar: data.avatar, name: data.name, description: data.description, website: data.website, nfts: data.nfts, likes: data.likes.filter({ $0 != id}), id: data.id)
                    self?.networkClient.send(request: UpdateProfileRequest(profile: newProfile), type: User.self) { result in
                        switch result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
