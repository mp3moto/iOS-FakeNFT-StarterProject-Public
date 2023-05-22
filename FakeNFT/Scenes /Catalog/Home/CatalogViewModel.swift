import Foundation

//MARK: вынести все структуры в одно место, куда укажет команда
struct NFTCollection: Codable {
    let createdAt: String
    let name: String
    let cover: String
    let nfts: [Int]
    let description: String
    let author: Int
    let id: String
}

struct NFTCollectionListItem {
    let id: Int
    let name: String
    let cover: String
    let nftsCount: Int
}

enum SortAttribute {
    case name
    case nftCount
}

//MARK: вынести протоколы в отдельные файлы по завешению
protocol CatalogViewModelProtocol {
    var onNFTCollectionsUpdate: (() -> Void)? { get set }
    var NFTCollections: [NFTCollection]? { get }
    var NFTCollectionsList: [NFTCollectionListItem]? { get }
    var NFTCollectionsCount: Int? { get }
    func getNFTCollections()
    func getCellViewModel(at indexPath: IndexPath) -> NFTCollectionListItem?
    func sortNFTCollections(by: SortAttribute)
}

class CatalogViewModel: CatalogViewModelProtocol {
    var onNFTCollectionsUpdate: (() -> Void)?
    var NFTCollections: [NFTCollection]?
    var NFTCollectionsList: [NFTCollectionListItem]?
    var NFTCollectionsCount: Int?
    var model: CatalogModelProtocol
    
    init(model: CatalogModelProtocol) {
        self.model = model
    }
    
    func getNFTCollections() {
        model.getNFTCollections { [weak self] result in
            switch result {
            case .success(let data):
                self?.NFTCollections = data
                self?.NFTCollectionsCount = data.count
                self?.NFTCollectionsList = self?.convert(collection: data)
                //self?.NFTCollectionsList?.sort { $0.name < $1.name }
                self?.onNFTCollectionsUpdate?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sortNFTCollections(by: SortAttribute) {
        switch by {
        case .name:
            NFTCollectionsList?.sort { $0.name < $1.name }
        case .nftCount:
            NFTCollectionsList?.sort { $0.nftsCount < $1.nftsCount }
        }
        onNFTCollectionsUpdate?()
    }
    
    func convert(collection: [NFTCollection]) -> [NFTCollectionListItem] {
        var list: [NFTCollectionListItem] = []
        collection.forEach {
            guard let id = Int($0.id) else { return }
            list.append(
                NFTCollectionListItem(
                    id: id,
                    name: $0.name,
                    cover: $0.cover,
                    nftsCount: $0.nfts.count
                )
            )
        }
        return list
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> NFTCollectionListItem? {
        guard let list = NFTCollectionsList,
            indexPath.row < list.count
        else { return nil }
        return list[indexPath.row]
    }
}
