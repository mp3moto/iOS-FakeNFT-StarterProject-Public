import UIKit

final class CatalogNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //pushViewController(CatalogViewController(), animated: false)
        //pushViewController(NFTViewController(id: 1), animated: true)
        
        //let image = UIImage(named: "nftSample")!
        //pushViewController(NFTImageSlideViewController(image: image), animated: false)
        
        pushViewController(TemporaryViewController(), animated: false)
    }
}
