//
//  Texts.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 30/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import Foundation

final class Texts {
    private init() {}

    // MARK: - Grocery List Scene
    struct GroceryListScene {

        // - Grocery List View
        static var navigationTitle = LocalizedString(texts: [
            .enUS: "Shopping list",
            .ptBR: "Lista de compras"
        ])

        // - Grocery Footer View
        static var footerTotalLabel = LocalizedString(texts: [
            .enUS: "TOTAL:",
            .ptBR: "TOTAL:"
        ])

        // - Grocery Item View
        static var groceryNameTextFieldPlaceholder = LocalizedString(texts: [
            .enUS: "Item name",
            .ptBR: "Nome do item"
        ])
        static var priceTextLabel = LocalizedString(texts: [
            .enUS: "Price:",
            .ptBR: "Preço:"
        ])
        static var quantityTextLabel = LocalizedString(texts: [
            .enUS: "Quantity:",
            .ptBR: "Quantidade:"
        ])
        static var unitSegmetedControl_Title0 = LocalizedString(texts: [
            .enUS: "Unit",
            .ptBR: "Unidade"
        ])
        static var itemTotalLabel = LocalizedString(texts: [
            .enUS: "Total:",
            .ptBR: "Total:"
        ])
        static var addButton = LocalizedString(texts: [
            .enUS: "Save",
            .ptBR: "Salvar"
        ])
    }
}
