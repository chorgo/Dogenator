//
//  DogesCollectionViewController.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import UIKit

final class DogesCollectionViewController: UICollectionViewController {

    private let viewModel: DogesViewModelProtocol
    private let session: SessionWrapper

    private let reuseIdentifier = "DogeCollectionCell"

    init(with viewModel: DogesViewModelProtocol, session: SessionWrapper) {
        self.viewModel = viewModel
        self.session = session
        super.init(collectionViewLayout: UICollectionViewFlowLayout())

        collectionView.register(DogesCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white

        title = "Dogenator"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Can't be started by coder")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        viewModel.loadNext()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section == 0 else {
            return 0
        }
        return viewModel.doges.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard indexPath.section == 0 else {
            return cell
        }
        guard indexPath.row < viewModel.doges.count else {
            return cell
        }
        guard let dogeCell = cell as? DogesCollectionCell else {
            return cell
        }
        dogeCell.loadImage(from: viewModel.doges[indexPath.row], session: session)
        return dogeCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else {
            return
        }
        guard indexPath.row < viewModel.doges.count else {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath)
        guard let dogeCell = cell as? DogesCollectionCell else {
            return
        }
        dogeCell.loadImage(from: viewModel.doges[indexPath.row], session: session)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.doges.count - 5 ) {
            viewModel.loadNext()
        }
    }

}

extension DogesCollectionViewController: DogesViewModelDelegate {

    func insertedDoges(at newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: newIndexPaths)
        }, completion: nil)
    }

}

extension DogesCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - collectionView.contentInset.left - collectionView.contentInset.right
        return CGSize(width: width, height: width * 9.0 / 16.0)
    }

}
