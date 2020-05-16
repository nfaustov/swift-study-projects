//
//  Item5ViewController.swift
//  StudyProject7
//
//  Created by Nikolai Faustov on 20.04.2020.
//  Copyright © 2020 Nikolai Faustov. All rights reserved.
//

import UIKit

class Item5ViewController: UIPageViewController {
    
    var pages: [UIViewController] = [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page1"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page2"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page3")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension Item5ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return pages.last}
        guard pages.count > previousIndex else {return nil}
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard pages.count != nextIndex else {return pages.first}
        guard pages.count >= nextIndex else {return nil}
        return pages[nextIndex]
    }
}
