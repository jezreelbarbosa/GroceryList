//
//  DomainAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import Domain

class DomainAssembly {

    private func assembleApp(_ container: Container) {

    }
}

extension DomainAssembly: Assembly {

    func assemble(container: Container) {
        assembleApp(container)
    }
}
