import UIKit

final class SimpleCell: UICollectionViewCell {
    static let reuseIdentifier = "cell01"
    
    var viewModel: NFTCollectionNFTItem? {
        didSet {
            guard let viewModel = viewModel else { return }
            //collectionName.text = "\(viewModel.name) (\(viewModel.nftsCount))"
            
            if let url = URL(string: viewModel.image.encodeUrl) {
                nftImage.kf.setImage(with: url)
            }
        }
    }
    
    private var nftImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        //contentView.addSubview(nftImage)
        
        NSLayoutConstraint.activate([
            //nftImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            //nftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            //nftImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //nftImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 108),
            //nftImage.widthAnchor.constraint(equalToConstant: 0)
            //nftImage.heightAnchor.constraint(equalToConstant: 108),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
