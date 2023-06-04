import UIKit

final class NFTItemCell: UICollectionViewCell {
    static let reuseIdentifier = "nftItemCell"
    
    var viewModel: NFTCollectionNFTItem? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            if let url = URL(string: viewModel.image.encodeUrl) {
                nftImage.kf.setImage(with: url)
            }
            renderRatingView(view: nftRatingView, value: viewModel.rating)
            nftName.text = viewModel.name
            nftPrice.text = viewModel.price.removeZerosFromEnd() + " " + CryptoCoin.ETH.rawValue
            
            if viewModel.liked {
                likeButton.setImage(UIImage(named: "like"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "noLike"), for: .normal)
            }
            
            if viewModel.inCart {
                cartButton.setImage(UIImage(named: "removeFromCart"), for: .normal)
            } else {
                cartButton.setImage(UIImage(named: "addToCart"), for: .normal)
            }
        }
    }
    
    private let nftImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftRatingView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftNameAndPriceView: UIView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftName = CustomLabel(style: .nftCollectionNameInNFTCollectionList)
    private let nftPrice = CustomLabel(style: .priceInNFTCell)
    
    private let cartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addToCart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "like"), for: .normal)
        button.imageView?.tintColor = UIColor(hexString: "#F56B6C")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nftImage)
        contentView.addSubview(nftRatingView)
        contentView.addSubview(nftNameAndPriceView)
        nftNameAndPriceView.addSubview(nftName)
        nftNameAndPriceView.addSubview(nftPrice)
        contentView.addSubview(cartButton)
        contentView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            nftImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftImage.heightAnchor.constraint(equalTo: nftImage.widthAnchor),
            
            nftRatingView.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 8),
            nftRatingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftRatingView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            nftRatingView.bottomAnchor.constraint(equalTo: nftRatingView.topAnchor, constant: 12),
            
            nftNameAndPriceView.topAnchor.constraint(equalTo: nftRatingView.bottomAnchor, constant: 5),
            nftNameAndPriceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftNameAndPriceView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.63),
            nftNameAndPriceView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nftName.topAnchor.constraint(equalTo: nftNameAndPriceView.topAnchor),
            nftName.leadingAnchor.constraint(equalTo: nftNameAndPriceView.leadingAnchor),
            nftName.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            
            nftPrice.bottomAnchor.constraint(equalTo: nftNameAndPriceView.bottomAnchor),
            nftPrice.leadingAnchor.constraint(equalTo: nftNameAndPriceView.leadingAnchor),
            nftPrice.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            
            cartButton.centerYAnchor.constraint(equalTo: nftNameAndPriceView.centerYAnchor),
            cartButton.leadingAnchor.constraint(greaterThanOrEqualTo: nftNameAndPriceView.trailingAnchor),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            likeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            likeButton.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderRatingView(view: UIStackView, value: Int) {
        let val = value < 0 || value > 5 ? 0 : value
        let grayStarsCount = 5 - val
        if val > 0 {
            for _ in 1...val {
                view.addArrangedSubview(starView(filled: true))
            }
        }
        if grayStarsCount > 0 {
            for _ in 1...grayStarsCount {
                view.addArrangedSubview(starView(filled: false))
            }
        }
    }
    
    func starView(filled: Bool) -> UIImageView {
        let star = UIImageView(image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate))
        star.tintColor = filled ? UIColor.starYellow : UIColor.starGray
        return star
    }
}
