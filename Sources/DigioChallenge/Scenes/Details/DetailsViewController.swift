//
//  DetailsViewController.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 18/08/24.
//

import UIKit

final class DetailsViewController: UIViewController {

    var detailModel: ProductDetailModel
    var mainView: DetailsView

    init(model: ProductDetailModel) {
        self.detailModel = model
        self.mainView = DetailsView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = AppStyle.Colors.tealColor
        title = ""

        self.view = mainView
        mainView.configure(withModel: detailModel)
    }
}
