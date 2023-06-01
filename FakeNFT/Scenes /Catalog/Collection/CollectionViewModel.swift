import Foundation

//MARK: вынести протоколы в отдельные файлы по завешению
protocol CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)? { get set }
    var onNFTAuthorUpdate: (() -> Void)? { get set }
    var onNFTItemsUpdate: (() -> Void)? { get set }
    //var nftItems: [NFTCollectionNFTItem]? { get }
    func getNFTCollectionInfo()
    func getNFTCollectionAuthor(id: Int)
    func getNFTItems()
    var nftCollection: NFTCollection? { get }
    var nftCollectionAuthor: NFTCollectionAuthor? { get }
    var NFTItemsCount: Int? { get }
}

final class CollectionViewModel: CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)?
    var onNFTAuthorUpdate: (() -> Void)?
    var onNFTItemsUpdate: (() -> Void)?
    private(set) var nftItems: [NFTItem]?
    var model: CollectionModelProtocol
    var nftCollection: NFTCollection?
    var nftCollectionAuthor: NFTCollectionAuthor?
    var NFTItemsCount: Int?
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
                self?.NFTItemsCount = data.nfts.count
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
    
    func getAllNFTs() {
        model.getAllNFTs { [weak self] result in
            switch result {
            case .success(let data):
                self?.nftItems = data
                //self?.getNFTItems()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func getNFTItems() {
        guard let nftItems = nftItems else { return }
        
    }
}
