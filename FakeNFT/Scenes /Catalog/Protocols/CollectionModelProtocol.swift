import Foundation

protocol CollectionModelProtocol {
    var networkClient: NetworkClient { get }
    func getNFTCollectionInfo(id: Int, completion: @escaping (Result<NFTCollection, Error>) -> Void)
    func getNFTCollectionAuthor(id: Int, completion: @escaping (Result<NFTCollectionAuthor, Error>) -> Void)
    func getAllNFTs(completion: @escaping (Result<[NFTItem], Error>) -> Void)
    func getLikedNFTs(completion: @escaping (Result<NFTLiked, Error>) -> Void)
    func getNFTsInCart(completion: @escaping (Result<NFTsInCart, Error>) -> Void)
}
