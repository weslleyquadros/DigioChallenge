//
//  DetailsViewController.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

class DetailsViewController: UIViewController {

    var detailModel: ProductDetailModel

    init(model: ProductDetailModel) {
        self.detailModel = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = AppStyle.Colors.tealColor
        self.navigationController?.navigationBar.topItem?.title = ""

        let view = DetailsView()
        self.view = view
        view.configure(withModel: detailModel)
    }

}
