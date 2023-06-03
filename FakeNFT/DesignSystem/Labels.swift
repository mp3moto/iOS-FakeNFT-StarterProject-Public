import UIKit

enum LabelStyles: String {
    case nftCollectionNameInNFTCollectionList
    case nftName
    case priceLabel
    case cryptocurrencyName
}

final class CustomLabel: UILabel {
    var style: LabelStyles?
    
    init(style: LabelStyles) {
        super.init(frame: .zero)
        self.style = style
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .nftCollectionNameInNFTCollectionList:
            font = CustomFont.font(name: .SFProTextBold, size: 17)
        case .nftName:
            font = CustomFont.font(name: .SFProTextBold, size: 22)
        case .priceLabel:
            font = CustomFont.font(name: .SFProTextRegular, size: 15)
        case .cryptocurrencyName:
            font = CustomFont.font(name: .SFProTextRegular, size: 13)
        }
        
        switch style {
        case .nftCollectionNameInNFTCollectionList, .nftName, .priceLabel, .cryptocurrencyName:
            textColor = UIColor.NFTBlack
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
