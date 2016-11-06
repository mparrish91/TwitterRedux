//
//  AppDelegate.swift
//  TwitterRedux
//
//  Created by parry on 11/4/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor.lightGray

        
        if TRUser.currentUser != nil
        {
            //we have a current user, show them loading then tweets view
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            
            let loadingVC = storyboard.instantiateViewController(withIdentifier: "TRLoadingViewController") as! TRLoadingViewController
            
            if let currentUser = TRUser.currentUser {
                print("User already logged in: \(currentUser.name)")
                window?.rootViewController = loadingVC
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // your code here
                    self.animateTwitterFeed()
                }

            }
        }
        else{
            print("No current user logged in yet")

        }

        // Add notification send user back to login screen after logout
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogout), name: userLogout, object: nil)
        
        
        

        
        return true
    }
    
    
    func animateTwitterFeedWithHamburgerMenu()
    {
        //setup Hamburger menu
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hamburgerViewController = storyboard.instantiateViewController(withIdentifier: "TRHamburgerViewController") as! TRHamburgerViewController        
        let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! TRMenuViewController
        
        menuViewController.hamburgerViewController = hamburgerViewController
        hamburgerViewController.menuViewController = menuViewController

        
        UIView.transition(with: window!, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: {
            window?.rootViewController = hamburgerViewController
        }) { (success: Bool) in
            //completion code
            
            
        }
        
    }

    
    
    func handleLogout() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateInitialViewController()
        UIView.transition(with: window!, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: {
            self.window?.rootViewController = rootVC
        }) { (success: Bool) in
            //completion code
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        // Complete OAuth authentication
        TRTwitterNetworkingClient.sharedInstance.completeLogin(with: url)
        
        return true
    }



}

