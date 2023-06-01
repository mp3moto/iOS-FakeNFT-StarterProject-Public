import Foundation

final class CollectionMockViewModel: CollectionViewModelProtocol {
    var onNFTCollectionInfoUpdate: (() -> Void)?
    var onNFTAuthorUpdate: (() -> Void)?
    var nftCollection: NFTCollection?
    var nftCollectionAuthor: NFTCollectionAuthor?
    var NFTItemsCount: Int?
    
    func getNFTCollectionInfo() {
        nftCollection = NFTCollection(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Beige",
            cover: "https://code.s3.yandex.net/Mobile/iOS/NFT/Обложки_коллекций/Beige.png",
            nfts: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21],
            description: "A series of one-of-a-kind NFTs featuring historic moments in sports history.",
            author: 6,
            id: "1"
        )
        NFTItemsCount = nftCollection?.nfts.count
        onNFTCollectionInfoUpdate?()
    }
    
    func getNFTCollectionAuthor(id: Int) {
        nftCollectionAuthor = NFTCollectionAuthor(name: "Aria Davis", website: "https://practicum.yandex.ru/middle-frontend/")
    }
    
    
    
    
}
