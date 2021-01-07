//
//  AppDataAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain
import AppData

class AppDataAssembly {

    private func assembleApp(_ container: Container) {

    }
}

extension AppDataAssembly: Assembly {

    func assemble(container: Container) {
        assembleApp(container)
    }
}
