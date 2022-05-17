//
//  DaangnTabBarController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/18.
//

import UIKit

final class DaangnTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setTabBarController()
    }
    
    private func configureUI() {
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.borderColor = UIColor.daangnGray01.cgColor
        self.tabBar.layer.borderWidth = 1
    }
    
    private func setTabBarController() {
        guard let homeViewController = UIStoryboard.init(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        let viliageViewController = UIViewController()
        let myLocationViewController = UIViewController()
        let chatViewController = UIViewController()
        let myDaangnViewController = UIViewController()
        
        homeViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_home_24"), selectedImage: UIImage(named: "ic_home_24_fill"))
        viliageViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_viliage_24"), selectedImage: UIImage(named: "icn_search_selected"))
        myLocationViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_gps_24"), selectedImage: UIImage(named: "icn_reels_selected"))
        chatViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_talk_24"), selectedImage: UIImage(named: "ic_talk_24_fill"))
        myDaangnViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "ic_mypage_24"), selectedImage: UIImage(named: "icn_profile_selected"))
        
        setViewControllers([homeViewController, viliageViewController, myLocationViewController, chatViewController, myDaangnViewController], animated: true)
    }
}
