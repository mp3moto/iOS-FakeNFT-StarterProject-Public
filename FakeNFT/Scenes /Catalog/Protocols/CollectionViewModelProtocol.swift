import Foundation

protocol CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)? { get set }
    var onNFTAuthorUpdate: (() -> Void)? { get set }
    var onNFTItemsUpdate: (() -> Void)? { get set }
    var nftCollection: NFTCollection? { get }
    var nftCollectionAuthor: NFTCollectionAuthor? { get }
    var nftCollectionItems: [NFTCollectionNFTItem]? { get }
    var nftCollectionItemsCount: Int? { get }
    var converter: CryptoConverterProtocol { get }

    func getNFTCollectionInfo()
    func getNFTCollectionAuthor(id: Int)
    func getNFTCollectionItems()
}
