//
//  DaangnTabBarController.swift
//  DaangnMarket
//
//  Created by madilyn on 2022/05/19.
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

        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "icHome24Unfill"), selectedImage: UIImage(named: "icHome24Fill"))
        viliageViewController.tabBarItem = UITabBarItem(title: "동네생활", image: UIImage(named: "icViliage24Unfill"), selectedImage: UIImage(named: "icViliage24Fill"))
        myLocationViewController.tabBarItem = UITabBarItem(title: "내 근처", image: UIImage(named: "icGps24Unfill"), selectedImage: UIImage(named: "icGps24Fill"))
        chatViewController.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "icTalk24Unfill"), selectedImage: UIImage(named: "icTalk24Fill"))
        myDaangnViewController.tabBarItem = UITabBarItem(title: "나의 당근", image: UIImage(named: "icMypage24Unfill"), selectedImage: UIImage(named: "icMypage24Fill"))

        [homeViewController, viliageViewController, myLocationViewController, chatViewController, myDaangnViewController].forEach {
            $0.tabBarItem.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.daangnBlack], for: .selected)
        }

        setViewControllers([homeViewController, viliageViewController, myLocationViewController, chatViewController, myDaangnViewController], animated: true)
    }
}
