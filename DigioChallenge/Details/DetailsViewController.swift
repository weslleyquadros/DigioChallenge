//
//  DetailsViewController.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

class DetailsViewController: UIViewController {

    var name: String
    var descriptionText: String

    init(name: String, descriptionText: String) {
        self.name = name
        self.descriptionText = descriptionText
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""

        let view = DetailsView()
        self.view = view
        view.configure(name: name, description: descriptionText)
    }

}
