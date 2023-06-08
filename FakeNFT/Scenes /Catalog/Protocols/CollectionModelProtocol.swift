import Foundation

protocol CollectionModelProtocol {
    var networkClient: NetworkClient { get }
    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func getNFTCollectionInfo(id: Int, completion: @escaping (Result<NFTCollection, Error>) -> Void)
    func getNFTCollectionAuthor(id: Int, completion: @escaping (Result<NFTCollectionAuthor, Error>) -> Void)
    func getAllNFTs(completion: @escaping (Result<[NFTItem], Error>) -> Void)
    func getLikedNFTs(completion: @escaping (Result<NFTLiked, Error>) -> Void)
    func getNFTsInCart(completion: @escaping (Result<NFTsInCart, Error>) -> Void)
    func toggleNFTItemInCart(id: Int, completion: @escaping (Result<Order, Error>) -> Void)
    func toggleNFTLikeInProfile(id: Int, completion: @escaping (Result<User, Error>) -> Void)
}
