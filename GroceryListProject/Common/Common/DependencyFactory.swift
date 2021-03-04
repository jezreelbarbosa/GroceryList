//
//  DependencyFactory.swift
//  Common
//
//  Created by Jezreel Barbosa on 07/01/21.
//

import Swinject

public protocol DependencyFactory: AnyObject {

    init(resolver: Resolver)
}
