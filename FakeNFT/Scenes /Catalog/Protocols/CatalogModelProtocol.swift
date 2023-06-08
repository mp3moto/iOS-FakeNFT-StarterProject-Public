import Foundation

protocol CatalogModelProtocol {
    var networkClient: NetworkClient { get }
    func getNFTCollections(completion: @escaping (Result<[NFTCollection], Error>) -> Void)
    func getData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
