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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "noLike"), style: .plain, target: self, action: #selector(toggleLike))
        
        let button = UIBarButtonItem(image: UIImage(named: "like"), style: .plain, target: self, action: #selector(toggleLike))
        button.tintColor = UIColor(hexString: "#F56B6C")
        navigationItem.rightBarButtonItem = button
    }
    //----------
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let slide1 = NFTImageSlideViewController(image: UIImage(named: "nftSample")!, asChildView: true)
        let slide2 = NFTImageSlideViewController(image: UIImage(named: "cover")!, asChildView: true)
        let slideShowVC = NFTImageSlideShowPageViewController(orderedViewControllers: [slide1, slide2])
        //slideShowVC.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 403)
        addChild(slideShowVC)
        
        contentView.addSubview(slideShowVC.view)
        
        print(slideShowVC.view.frame)
        print(slideShowVC.view.bounds)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        if let childView = slideShowVC.view {
            childView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                childView.topAnchor.constraint(equalTo: contentView.topAnchor),
                childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                childView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: 28),
                
                contentView.bottomAnchor.constraint(equalTo: childView.bottomAnchor)
            ])
        }
        
        slideShowVC.didMove(toParent: self)
    }
    
    func setupConstraints() {
        
    }
    
    @objc private func toggleLike() {
        
    }
}
