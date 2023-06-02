import UIKit

final class TemporaryViewController: UIViewController {
    private let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("open", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(openSlideShow), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func openSlideShow() {
        let slide1 = NFTImageSlideViewController(image: UIImage(named: "nftSample")!, asChildView: false)
        let slide2 = NFTImageSlideViewController(image: UIImage(named: "cover")!, asChildView: false)
        let vc = NFTImageSlideShowPageViewController(orderedViewControllers: [slide1, slide2])
        present(vc, animated: true)
    }
}
