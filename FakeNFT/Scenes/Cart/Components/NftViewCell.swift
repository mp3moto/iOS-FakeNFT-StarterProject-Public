//
// Created by Сергей Махленко on 02.06.2023.
//

import UIKit

class NftViewCell: UITableViewCell, ReuseIdentifying {

    private var deleteTapHandle: (() -> Void)?

    // MARK: - UI elements

    private var previewImageView: UIImageView = {
        let imageView = ImageViewWithPreloading()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .asset(.black)
        label.text = "April"
        return label
    }()

    private var ratingView: UIView = {
        let rating = RatingView()
        return rating
    }()

    private var costLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .asset(.black)
        label.text = "1,78 ETH"
        return label
    }()

    lazy private var removeButton: UIButton = {
        let button = UIButton()
        button.setImage(.asset(.trash), for: .normal)
        button.addTarget(self, action: #selector(didTapRemove), for: .touchUpInside)
        return button
    }()

    lazy private var cellStackView: UIStackView = {
        let priceLabel = UILabel()
        priceLabel.text = "Цена"
        priceLabel.font = .caption2
        priceLabel.textColor = .asset(.black)

        let topRowContentStackView = UIStackView(arrangedSubviews: [titleLabel, ratingView])
        let bottomRowContentStackView = UIStackView(arrangedSubviews: [priceLabel, costLabel])
        let contentStackView = UIStackView(arrangedSubviews: [topRowContentStackView, bottomRowContentStackView])
        let cellStackView = UIStackView(arrangedSubviews: [previewImageView, contentStackView, removeButton])

        [topRowContentStackView, bottomRowContentStackView, contentStackView].forEach({
            $0.axis = .vertical
        })

        topRowContentStackView.spacing = 4
        topRowContentStackView.spacing = 2
        contentStackView.spacing = 12
        cellStackView.spacing = 20

        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.alignment = .center
        cellStackView.distribution = .fill

        return cellStackView
    }()

    // MARK: - Setup methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        selectionStyle = .none
        backgroundColor = .asset(.white)
        contentView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentView.insetsLayoutMarginsFromSafeArea = true

        contentView.addSubview(cellStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            previewImageView.heightAnchor.constraint(equalToConstant: 108),
            previewImageView.widthAnchor.constraint(equalTo: previewImageView.heightAnchor, multiplier: 1)
        ])

        NSLayoutConstraint.activate([
            removeButton.widthAnchor.constraint(equalToConstant: 44),
            removeButton.heightAnchor.constraint(equalTo: removeButton.widthAnchor, multiplier: 1)
        ])
    }

    // MARK: - Setup cell data

    func setup(deleteTapHandle: (() -> Void)? = nil) {
        self.deleteTapHandle = deleteTapHandle
    }

    // MARK: - Actions

    @objc private func didTapRemove() {
        deleteTapHandle?()
    }
}
