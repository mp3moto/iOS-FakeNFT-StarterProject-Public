import UIKit

final class NFTImageSlideShowPageViewController: UIPageViewController {
    private var orderedViewControllers: [UIViewController]
    private let pageControl = UIPageControl()
    
    init(orderedViewControllers: [UIViewController]) {
        self.orderedViewControllers = orderedViewControllers
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .systemBackground
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
        
        pageViewController(self, didUpdatePageCount: orderedViewControllers.count)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(named: "NFTBlack")
        pageControl.pageIndicatorTintColor = UIColor(named: "NFTBlack")?.withAlphaComponent(0.3)
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            pageControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
    }
}

extension NFTImageSlideShowPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let firstVC = viewControllers?.first,
           let index = orderedViewControllers.firstIndex(of: firstVC) {
            self.pageViewController(self, didUpdatePageIndex: index)
        }
    }
    
    func pageViewController(_ pageViewController: NFTImageSlideShowPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func pageViewController(_ pageViewController: NFTImageSlideShowPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}

extension NFTImageSlideShowPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let prevIndex = viewControllerIndex - 1
        
        guard !(prevIndex < 0) else { return nil }
        return orderedViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < orderedViewControllers.count else { return nil }
        return orderedViewControllers[nextIndex]
    }
}
