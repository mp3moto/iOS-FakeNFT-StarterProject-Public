import Foundation

protocol CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)? { get set }
    var onNFTAuthorUpdate: (() -> Void)? { get set }
    var onNFTItemsUpdate: (() -> Void)? { get set }
    var onNFTChanged: (() -> Void)? { get set }
    var showAlertClosure: (() -> Void)? { get set }
    var errorMessage: String? { get }
    var updateLoadingStatus: (() -> Void)? { get set }
    var isLoading: Bool { get set }
    var nftCollection: NFTCollection? { get }
    var nftCollectionAuthor: NFTCollectionAuthor? { get }
    var nftCollectionItems: [NFTCollectionNFTItem]? { get }
    var nftCollectionItemsCount: Int? { get }
    var converter: CryptoConverterProtocol { get }

    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func getNFTCollectionInfo()
    func getNFTCollectionAuthor(id: Int)
    func getNFTCollectionItems()
    func toggleCart(id: Int)
    func toggleLike(id: Int)
}
