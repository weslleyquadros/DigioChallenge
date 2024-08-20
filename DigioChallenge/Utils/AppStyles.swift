//
//  AppStyles.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

struct AppStyle {
    struct Colors {
        static let primary = UIColor(red: 32/255.0, green: 43/255.0, blue: 71/255.0, alpha: 1.0)
        static let secondary = UIColor(red: 141/255.0, green: 141/255.0, blue: 141/255.0, alpha: 1.0)
        static let tealColor = UIColor(red: 11/255.0, green: 193/255.0, blue: 176/255.0, alpha: 1.0)
    }

    struct Fonts {
        static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: "ProximaNova-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }

        static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: "ProximaNova-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }

        static func light(size: CGFloat) -> UIFont {
            return UIFont(name: "ProximaNova-Light", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }

    struct Assets {
        static let reloadIcon = UIImage(named: "reload_icon")
        static let noImageIcon = UIImage(named: "no-image-icon")
    }
}
