//
//  UIImageView+Extension.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.image = UIImage(named: "no-image-icon")
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "no-image-icon")
                }
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "no-image-icon")
                }
            }
        }.resume()
    }
}
