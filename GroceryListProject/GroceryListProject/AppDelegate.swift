//
//  AppDelegate.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Swinject
import Domain
import DI
import Common
import Presentation
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Properties

    var window: UIWindow?

    private var dependencyInjector: DependencyInjector!
    private var assembler: Assembler!

    // Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        Font.registerFonts()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = LocalizedString(texts: [
            .enUS: "Done",
            .ptBR: "Concluído"
        ]).localizedText

        dependencyInjector = DependencyInjector(launchOptions: launchOptions, window: window)
        dependencyInjector.build(completion: { [unowned self] (assembler, appCoordinator) in
            self.assembler = assembler
            appCoordinator.start()
        })

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // applicationWillResignActive
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // applicationDidEnterBackground
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // applicationWillEnterForeground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // applicationDidBecomeActive
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // applicationWillTerminate
    }
}
