//
//  CarouselFlowLayout.swift
//  DigioChallenge
//
//  Created by Weslley Tavares de Aguiar e Quadros on 19/08/24.
//

import UIKit

final class CarouselFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()

        if let collectionView = collectionView {
            let itemWidth = collectionView.bounds.width - 48
            let itemHeight = collectionView.bounds.height
            itemSize = CGSize(width: itemWidth, height: itemHeight)
            sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            minimumLineSpacing = 0
            scrollDirection = .horizontal
        }
    }

    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
            )
        }

        let targetRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
        guard let layoutAttributes = super.layoutAttributesForElements(in: targetRect) else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
            )
        }

        var closestAttribute: UICollectionViewLayoutAttributes?
        for attributes in layoutAttributes {
            if closestAttribute == nil ||
                abs(attributes.center.x - proposedContentOffset.x - collectionView.bounds.width / 2) <
                abs(closestAttribute!.center.x - proposedContentOffset.x - collectionView.bounds.width / 2) {
                closestAttribute = attributes
            }
        }

        return CGPoint(x: closestAttribute!.center.x - collectionView.bounds.width / 2, y: proposedContentOffset.y)
    }
}
