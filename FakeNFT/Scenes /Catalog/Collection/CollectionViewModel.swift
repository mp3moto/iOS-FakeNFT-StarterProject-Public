import Foundation

//MARK: вынести протоколы в отдельные файлы по завешению
protocol CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)? { get set }
    var onNFTAuthorUpdate: (() -> Void)? { get set }
    var onNFTItemsUpdate: (() -> Void)? { get set }
    
    var nftCollection: NFTCollection? { get }
    var nftCollectionAuthor: NFTCollectionAuthor? { get }
    var nftCollectionItems: [NFTCollectionNFTItem]? { get }
    var nftCollectionItemsCount: Int? { get }

    func getNFTCollectionInfo()
    func getNFTCollectionAuthor(id: Int)
    func getNFTCollectionItems()
}

final class CollectionViewModel: CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)?
    var onNFTAuthorUpdate: (() -> Void)?
    var onNFTItemsUpdate: (() -> Void)?
    
    private(set) var allNFTItems: [NFTItem]? {
        didSet {
            generateNFTdata()
        }
    }
    private(set) var nftsLiked: NFTLiked? {
        didSet {
            generateNFTdata()
        }
    }
    private(set) var nftsInCart: NFTsInCart? {
        didSet {
            generateNFTdata()
        }
    }
    
    var model: CollectionModelProtocol
    private(set) var nftCollection: NFTCollection?
    var nftCollectionAuthor: NFTCollectionAuthor?
    var nftCollectionItems: [NFTCollectionNFTItem]?
    var nftCollectionItemsCount: Int?
    var nftCollectionId: Int
    var networkClient: NetworkClient
    
    init(model: CollectionModelProtocol, nftCollectionId: Int, networkClient: NetworkClient) {
        self.model = model
        self.nftCollectionId = nftCollectionId
        self.networkClient = networkClient
    }
    
    func getNFTCollectionInfo() {
        model.getNFTCollectionInfo(id: nftCollectionId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.nftCollection = data
                //self?.NFTItemsCount = data.nfts.count
                self?.onNFTCollectionInfoUpdate?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNFTCollectionAuthor(id: Int) {
        model.getNFTCollectionAuthor(id: id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.nftCollectionAuthor = data
                self?.onNFTAuthorUpdate?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNFTCollectionItems() {
        allNFTItems = nil
        nftsLiked = nil
        nftsInCart = nil
        
        getAllNFTs { [weak self] result in
            switch result {
            case .success(let data):
                self?.allNFTItems = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        getLikedNFTs { [weak self] result in
            switch result {
            case .success(let data):
                self?.nftsLiked = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        getNFTsInCart { [weak self] result in
            switch result {
            case .success(let data):
                self?.nftsInCart = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllNFTs(completion: @escaping (Result<[NFTItem], Error>) -> Void) {
        model.getAllNFTs { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getLikedNFTs(completion: @escaping (Result<NFTLiked, Error>) -> Void) {
        model.getLikedNFTs { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNFTsInCart(completion: @escaping (Result<NFTsInCart, Error>) -> Void) {
        model.getNFTsInCart { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func generateNFTdata() {
        guard let allNFTItems = allNFTItems,
              let nftsLiked = nftsLiked,
              let nftsInCart = nftsInCart,
              let nfts = nftCollection?.nfts
        else { return }
        var result: [NFTCollectionNFTItem] = []
        
        nfts.forEach {
            let id = $0.self
            guard let nft = allNFTItems.first(where: { $0.id == "\(id)" }),
                  let image = nft.images.first
            else { return }
            
            let liked = nftsLiked.likes.filter { $0 == id }.count > 0 ? true : false
            let inCart = nftsInCart.nfts.filter { $0 == id }.count > 0 ? true : false
            
            result.append( NFTCollectionNFTItem(id: id, image: image, rating: nft.rating, name: nft.name, price: nft.price, liked: liked, inCart: inCart) )
        }
        /*
        allNFTItems.forEach {
            guard let id = Int($0.id),
                  nfts.filter({ $0 == id }).count > 0,
                  let image = $0.images.first
            else { return }
            let liked = nftsLiked.likes.filter { $0 == id }.count > 0 ? true : false
            let inCart = nftsInCart.nfts.filter { $0 == id }.count > 0 ? true : false
            
            result.append(
                NFTCollectionNFTItem(
                    id: id,
                    image: image,
                    rating: $0.rating,
                    name: $0.name,
                    price: $0.price,
                    liked: liked,
                    inCart: inCart
                )
            )
        }*/
        nftCollectionItems = result
        nftCollectionItemsCount = result.count
        onNFTItemsUpdate?()
        //return result
    }
    
    /*
    func getNFTItems() {
        guard let nftItems = nftItems else { return }
        
    }
     */
}
