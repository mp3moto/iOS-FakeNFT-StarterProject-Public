import UIKit

final class PriceListTableCell: UITableViewCell {
    static let reuseIdentifier = "priceListTableCell"
    
    var viewModel: NFTPriceListItem? {
        didSet {
            guard let viewModel = viewModel else { return }
            fullName.text = "\(viewModel.cryptocurrency.name) (\(viewModel.cryptocurrency.shortname))"
            coinImage.image = UIImage(named: viewModel.cryptocurrency.shortname.rawValue)
        }
    }
    /*
    private let coinImageBackground: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.NFTAlwaysBlack
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
    }()
    */
    private let coinImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = UIColor.NFTAlwaysBlack
        view.contentMode = .center
        //view.clipsToBounds = true
        //view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fullName = CustomLabel(style: .cryptocurrencyName)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in subviews where view != contentView {
            view.removeFromSuperview()
        }
    }
    
    private func configCell() {
        contentView.addSubview(coinImage)
        contentView.addSubview(fullName)
        
        NSLayoutConstraint.activate([
            coinImage.widthAnchor.constraint(equalToConstant: 32),
            coinImage.heightAnchor.constraint(equalToConstant: 32),
            coinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coinImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
