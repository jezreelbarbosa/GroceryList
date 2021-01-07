//
//  NetworkAssembly.swift
//  DI
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject
import AppData
import Networking

class NetworkingAssembly {

    private func assembleUser(_ container: Container) {

    }
}

extension NetworkingAssembly: Assembly {

    func assemble(container: Container) {
        assembleUser(container)
    }
}
