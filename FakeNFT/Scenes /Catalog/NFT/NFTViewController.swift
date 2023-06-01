import UIKit

final class NFTViewController: UIViewController {
    private let id: Int
    
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
    }
    
    func setupConstraints() {
        
    }
    
    @objc private func toggleLike() {
        
    }
}
