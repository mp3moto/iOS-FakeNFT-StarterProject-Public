import Foundation

protocol CatalogModelProtocol {
    var networkClient: NetworkClient? { get }
    func getNFTCollections(completion: @escaping (Result<[NFTCollection], Error>) -> Void)
}
