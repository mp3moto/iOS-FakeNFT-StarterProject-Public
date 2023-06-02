import UIKit

final class NFTImageSlideViewController: UIViewController {
    private let image: UIImage
    private let asChildView: Bool
    
    private let imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(image: UIImage, asChildView: Bool) {
        self.image = image
        self.asChildView = asChildView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        imageView.image = image
        
        if asChildView {
            imageView.layer.cornerRadius = 40
        }
        
        view.addSubview(imageView)
    }
    
    func setupConstraints() {
        if asChildView {
            imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        } else {
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
