//
//  PageViewController.swift
//  split-bills
//
//  Created by wimba prasiddha on 23/07/20.
//  Copyright © 2020 wimba prasiddha. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    
    @Binding var currentPageIndex: Int
    
    var viewController: [UIViewController]
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([viewController[currentPageIndex]], direction: .forward, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: PageViewController
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            //retrieves the index of currently displayed view controller
            guard let index = parent.viewController.firstIndex(of: viewController) else {
                return nil
            }
    
            //shows the last view controller when the user swipes back from the first view controller
            if index == 0 {
                return parent.viewController.last
            }
            
            //shows the view controller before the currently displayed view controller
            return parent.viewController[index - 1]
            
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
             //retrieves the index of currently displayed view controller
            guard let index = parent.viewController.firstIndex(of: viewController) else {
                return nil
            }
            
            //shows the first view controller when the user swipes back from the last view controller
            if index + 1 == parent.viewController.count {
                return parent.viewController.first
            }
            
              //shows the view controller after the currently displayed view controller
            return parent.viewController[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.viewController.firstIndex(of: visibleViewController){
            parent.currentPageIndex = index
            }
            
        }
        
    }
}
