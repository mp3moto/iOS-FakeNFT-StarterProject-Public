import UIKit

final class NFTViewController: UIViewController {
    private let id: Int
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let slideShowView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftInfoView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftNameAndRatingView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftName = CustomLabel(style: .nftName)
    
    private let ratingView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftCollectionName = CustomLabel(style: .nftCollectionNameInNFTCollectionList)
    
    private let nftPriceView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nftPriceLabel = CustomLabel(style: .priceLabel)
    private let nftPriceValueLabel = CustomLabel(style: .nftCollectionNameInNFTCollectionList)
    
    private let nftAddToCartButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Добавить в корзину", for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = UIColor.NFTBlack
        button.setTitleColor(UIColor.NFTWhite, for: .normal)
        button.titleLabel?.font = CustomFont.font(name: .SFProTextBold, size: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //TODO: Сделать это зависимостью от протокола
    private let convertService = FakeConvertService()
    
    private let priceListTableView = ContentSizedTableView()
    
    private let authorsWebsiteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Перейти на сайт продавца", for: .normal)
        button.layer.cornerRadius = 16
        button.setTitleColor(UIColor.NFTBlack, for: .normal)
        button.titleLabel?.font = CustomFont.font(name: .SFProTextRegular, size: 15)
        button.layer.borderColor = UIColor.NFTBlack.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupConstraints()
    }
    
    //TODO: перенести это в экран коллекции при тапе на ячейку
    private func setupNavigationBar() {
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", image: nil, target: nil, action: nil)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        //appearance.configureWithOpaqueBackground()

        //UINavigationBar.appearance().standardAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "noLike"), style: .plain, target: self, action: #selector(toggleLike))
        
        let button = UIBarButtonItem(image: UIImage(named: "like"), style: .plain, target: self, action: #selector(toggleLike))
        button.tintColor = UIColor(hexString: "#F56B6C")
        navigationItem.rightBarButtonItem = button
    }
    //----------
    
    func setupUI() {
        var topbarHeight: CGFloat {
            return (navigationController?.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
        
        var bottombarHeight: CGFloat {
            tabBarController?.tabBar.frame.height ?? 0
        }
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let childView = generateSlideShow()
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(childView)
        contentView.addSubview(nftInfoView)
        nftInfoView.addArrangedSubview(nftNameAndRatingView)
        nftNameAndRatingView.addSubview(nftName)
        nftNameAndRatingView.addSubview(ratingView)
        renderRatingView(view: ratingView, value: 3)
        nftInfoView.addArrangedSubview(nftCollectionName)
        contentView.addSubview(nftPriceView)
        nftPriceView.addSubview(nftPriceLabel)
        nftPriceView.addSubview(nftPriceValueLabel)
        nftPriceView.addSubview(nftAddToCartButton)
        contentView.addSubview(priceListTableView)
        contentView.addSubview(authorsWebsiteButton)

        nftName.text = "Daisy"
        nftCollectionName.text = "Peach"
        nftPriceLabel.text = "Цена"
        nftPriceValueLabel.text = "1,78 ETH"
        
        priceListTableView.translatesAutoresizingMaskIntoConstraints = false
        priceListTableView.register(PriceListTableCell.self, forCellReuseIdentifier: PriceListTableCell.reuseIdentifier)
        priceListTableView.separatorInset = UIEdgeInsets.zero
        priceListTableView.layoutMargins = UIEdgeInsets.zero
        priceListTableView.dataSource = self
        priceListTableView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo:  view.topAnchor, constant: -topbarHeight),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottombarHeight),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            childView.topAnchor.constraint(equalTo: contentView.topAnchor),
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 28),
            
            nftInfoView.topAnchor.constraint(equalTo: childView.bottomAnchor, constant: 16),
            nftInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftInfoView.bottomAnchor.constraint(equalTo: nftInfoView.topAnchor, constant: 28),
            
            nftNameAndRatingView.topAnchor.constraint(equalTo: nftInfoView.topAnchor),
            //nftNameAndRatingView.leadingAnchor.constraint(equalTo: nftInfoView.leadingAnchor),
            //nftNameAndRatingView.trailingAnchor.constraint(lessThanOrEqualTo: nftInfoView.trailingAnchor),
            nftNameAndRatingView.bottomAnchor.constraint(equalTo: nftInfoView.bottomAnchor),
            
            nftName.centerYAnchor.constraint(equalTo: nftNameAndRatingView.centerYAnchor),
            nftName.leadingAnchor.constraint(equalTo: nftNameAndRatingView.leadingAnchor),
            nftName.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndRatingView.trailingAnchor),
            
            ratingView.centerYAnchor.constraint(equalTo: nftNameAndRatingView.centerYAnchor),
            ratingView.leadingAnchor.constraint(equalTo: nftName.trailingAnchor, constant: 8),
            ratingView.trailingAnchor.constraint(lessThanOrEqualTo: nftNameAndRatingView.trailingAnchor),
            
            nftCollectionName.centerYAnchor.constraint(equalTo: nftInfoView.centerYAnchor),
            //nftCollectionName.leadingAnchor.constraint(equalTo: nftNameAndRatingView.trailingAnchor),
            //nftCollectionName.trailingAnchor.constraint(lessThanOrEqualTo: nftInfoView.trailingAnchor),
            
            nftPriceView.topAnchor.constraint(equalTo: nftInfoView.bottomAnchor, constant: 24),
            nftPriceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftPriceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nftPriceView.bottomAnchor.constraint(equalTo: nftPriceView.topAnchor, constant: 44),
            
            nftPriceLabel.topAnchor.constraint(equalTo: nftPriceView.topAnchor),
            nftPriceLabel.leadingAnchor.constraint(equalTo: nftPriceView.leadingAnchor),
            nftPriceLabel.trailingAnchor.constraint(lessThanOrEqualTo: nftPriceView.trailingAnchor),
            
            nftPriceValueLabel.topAnchor.constraint(equalTo: nftPriceLabel.bottomAnchor, constant: 2),
            nftPriceValueLabel.leadingAnchor.constraint(equalTo: nftPriceView.leadingAnchor),
            //nftPriceValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: nftPriceView.trailingAnchor),
            
            nftAddToCartButton.topAnchor.constraint(equalTo: nftPriceView.topAnchor),
            nftAddToCartButton.widthAnchor.constraint(equalTo: nftPriceView.widthAnchor, multiplier: 0.7),
            //nftAddToCartButton.leadingAnchor.constraint(equalTo: nftPriceValueLabel.trailingAnchor, constant: 28),
            nftAddToCartButton.trailingAnchor.constraint(equalTo: nftPriceView.trailingAnchor),
            nftAddToCartButton.bottomAnchor.constraint(equalTo: nftPriceView.bottomAnchor),
            
            priceListTableView.topAnchor.constraint(equalTo: nftPriceView.bottomAnchor, constant: 24),
            priceListTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceListTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //priceListTableView.heightAnchor.constraint(equalToConstant: priceListTableView.intrinsicContentSize.height),
            
            //priceListTableView.bottomAnchor.constraint(equalTo: priceListTableView.topAnchor, constant: CGFloat(72 * convertService.currenciesCount)),
            //priceListTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            //priceListTableView.heightAnchor.constraint(equalToConstant: 2000),
            //priceListTableView.bottomAnchor.constraint(equalTo: authorsWebsiteButton.topAnchor),
            
            authorsWebsiteButton.topAnchor.constraint(equalTo: priceListTableView.bottomAnchor, constant: 24),
            authorsWebsiteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            authorsWebsiteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorsWebsiteButton.heightAnchor.constraint(equalToConstant: 40),
            authorsWebsiteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //priceListTableView.bottomAnchor.constraint(equalTo: authorsWebsiteButton.topAnchor),
            
            //contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: authorsWebsiteButton.bottomAnchor),
            //contentView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor), //это работает
        ])
    }
    
    func generateSlideShow() -> UIView {
        let slide1 = NFTImageSlideViewController(image: UIImage(named: "nftSample")!, asChildView: true)
        let slide2 = NFTImageSlideViewController(image: UIImage(named: "cover")!, asChildView: true)
        let slideShowVC = NFTImageSlideShowPageViewController(orderedViewControllers: [slide1, slide2])
        addChild(slideShowVC)
        slideShowVC.didMove(toParent: self)
        return slideShowVC.view
    }
    
    func renderRatingView(view: UIStackView, value: Int) {
        let val = value < 0 || value > 5 ? 0 : value
        let grayStarsCount = 5 - val
        for _ in 1...val {
            view.addArrangedSubview(starView(filled: true))
        }
        for _ in 1...grayStarsCount {
            view.addArrangedSubview(starView(filled: false))
        }
    }
    
    func starView(filled: Bool) -> UIImageView {
        let star = UIImageView(image: UIImage(named: "star")?.withRenderingMode(.alwaysTemplate))
        star.tintColor = filled ? UIColor.starYellow : UIColor.starGray
        return star
    }
    
    func setupConstraints() {
        
    }
    
    @objc private func toggleLike() {
        
    }
}

extension NFTViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        convertService.currenciesCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceListTableCell.reuseIdentifier, for: indexPath) as? PriceListTableCell
              //let viewModel = ,
              //let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        else { return CatalogCell() }

        
        
        //cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
        //cell.viewModel = cellViewModel
        
        if indexPath.row == 0 {
            cell.contentView.layer.cornerRadius = 12
            cell.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        if indexPath.row == convertService.currenciesCount - 1 {
            cell.contentView.layer.cornerRadius = 12
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        }
        
        //Temporary
        let price = 18.11
        let cryptocurrency = convertService.getCryptocurrencies()[indexPath.row]
        //---------
        cell.viewModel = NFTPriceListItem(
            cryptocurrency: cryptocurrency,
            toCrypto: convertService.convertUSD(to: cryptocurrency.shortname, amount: price)
        )
        return cell
    }
    
    
}
