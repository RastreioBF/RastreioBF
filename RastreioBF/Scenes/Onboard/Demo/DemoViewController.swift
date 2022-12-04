//
//  DemoViewController.swift
//  RastreioBF
//
//  Created by Jessica Bigal on 09/09/22.
//

import UIKit

class DemoViewController: UIPageViewController, Coordinating {
    
    var coordinator: Coordinator?
    var pages = [UIViewController]()
    let skipButton = UIButton()
    let nextButton = UIButton()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    // animations
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension DemoViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 = OnboardingViewController(imageName: "firstSlide",
                                             subtitleText: LC.firstSubtitle.text)
        let page2 = OnboardingViewController(imageName: "secondSlide",
                                             subtitleText: LC.secondSubtitle.text)
        let page3 = OnboardingViewController(imageName: "thirdSlide",
                                             subtitleText: LC.thirdSubtitle.text)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: false, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(named: "mainPurpleColor")
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.white, for: .normal)
        skipButton.layer.cornerRadius = 8
        skipButton.backgroundColor = .lightGray
        skipButton.setTitle("Pular Introdução", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 8
        nextButton.backgroundColor = UIColor(named: "mainPurpleColor")
        nextButton.setTitle("RastreioBF", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            
            
            
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            skipButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45),
            skipButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45),
            skipButton.heightAnchor.constraint(equalToConstant: 40),
            skipButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            skipButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 15),
            
            nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45),
            nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -45),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            nextButton.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 15),
        ])
        
    }
}

// MARK: - DataSource

extension DemoViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap first
        }
    }
}

// MARK: - Delegates

extension DemoViewController: UIPageViewControllerDelegate {
    
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1
        
        if lastPage {
            hideControls()
        } else {
            showControls()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideControls() {
        nextButton.isHidden = false
        skipButton.isHidden = true
    }
    
    private func showControls() {
        nextButton.isHidden = true
        skipButton.isHidden = false
    }
}

// MARK: - Actions

extension DemoViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }
    
    @objc func skipTapped(_ sender: UIButton) {
        let vc: MainTabBarController = MainTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        let vc: MainTabBarController = MainTabBarController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extensions

extension UIPageViewController {
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}
