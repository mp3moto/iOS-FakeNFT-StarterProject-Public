import UIKit

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = self < 10000 ? 5 : 2
        return String(formatter.string(from: number) ?? "")
    }
}

final class PriceListTableCell: UITableViewCell {
    static let reuseIdentifier = "priceListTableCell"
    
    var viewModel: NFTPriceListItem? {
        didSet {
            guard let viewModel = viewModel else { return }
            fullName.text = "\(viewModel.cryptocurrency.name) (\(viewModel.cryptocurrency.shortname))"
            coinImage.image = UIImage(named: viewModel.cryptocurrency.shortname.rawValue)
            priceInUSD.text = "$18.11"
            priceInCrypto.text = viewModel.toCrypto.removeZerosFromEnd() + " (" + viewModel.cryptocurrency.shortname.rawValue + ")"
            //priceInCrypto.text = String(format: "%.5f", viewModel.toCrypto) + "(\(viewModel.cryptocurrency.shortname))"
            //priceInCrypto.text = String(format: "%g", viewModel.toCrypto) + "(\(viewModel.cryptocurrency.shortname))"
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
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let fullName = CustomLabel(style: .cryptocurrencyName)
    private let priceInUSD = CustomLabel(style: .priceLabel)
    private let priceInCrypto = CustomLabel(style: .priceInCrypto)
    
    private let chevronImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "chevron.forward"))
        view.contentMode = .center
        view.tintColor = UIColor.NFTBlack
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        contentView.backgroundColor = UIColor.starGray
        contentView.addSubview(coinImage)
        contentView.addSubview(fullName)
        contentView.addSubview(priceInUSD)
        contentView.addSubview(chevronImage)
        contentView.addSubview(priceInCrypto)
        
        NSLayoutConstraint.activate([
            coinImage.widthAnchor.constraint(equalToConstant: 32),
            coinImage.heightAnchor.constraint(equalToConstant: 32),
            coinImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            fullName.topAnchor.constraint(equalTo: coinImage.topAnchor, constant: -3),
            fullName.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 10),
            fullName.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            priceInUSD.bottomAnchor.constraint(equalTo: coinImage.bottomAnchor, constant: 2),
            priceInUSD.leadingAnchor.constraint(equalTo: coinImage.trailingAnchor, constant: 10),
            priceInUSD.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            
            chevronImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chevronImage.leadingAnchor.constraint(equalTo: chevronImage.trailingAnchor, constant: -8),
            chevronImage.heightAnchor.constraint(equalToConstant: 14),
            
            priceInCrypto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceInCrypto.leadingAnchor.constraint(greaterThanOrEqualTo: fullName.trailingAnchor),
            priceInCrypto.trailingAnchor.constraint(equalTo: chevronImage.leadingAnchor, constant: -16),
        ])
    }
}
