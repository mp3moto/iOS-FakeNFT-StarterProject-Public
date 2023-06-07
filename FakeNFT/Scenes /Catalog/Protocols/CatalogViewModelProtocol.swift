import Foundation

protocol CatalogViewModelProtocol {
    var onNFTCollectionsUpdate: (() -> Void)? { get set }
    var NFTCollections: [NFTCollection]? { get }
    var NFTCollectionsList: [NFTCollectionListItem]? { get }
    var model: CatalogModelProtocol { get }
    var NFTCollectionsCount: Int? { get }
    func getNFTCollections()
    func getCellViewModel(at indexPath: IndexPath) -> NFTCollectionListItem?
    func sortNFTCollections(by: SortAttribute)
}
