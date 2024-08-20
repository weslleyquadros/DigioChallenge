//
//  LocalizedString.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import Foundation

enum LocalizedString: String {
    case homeTitle = "home_title"
    case productsSection = "home_products_section"
    case digioCash = "home_digio_cash"
    case genericError = "home_generic_error"

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
