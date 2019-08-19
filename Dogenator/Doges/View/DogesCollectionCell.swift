//
//  DogesCollectionCell.swift
//  Dogenator
//
//  Created by Jan Theile on 07/08/2019.
//  Copyright © 2019 Chorgo. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, NSData>()

final class DogesCollectionCell: UICollectionViewCell {

    private var image: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = UIActivityIndicatorView.Style.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var error: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.orange
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var task: DataTaskWrapper?

    required init(coder aDecoder: NSCoder) {
        fatalError("Can't be started by coder")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(error)
        contentView.addSubview(image)
        contentView.addSubview(loader)

        setUpErrorConstraints()
        setUpImageConstraints()
        setUpLoaderConstraints()
    }

    func loadImage(from url: URL, session: SessionWrapper) {
        error.text = ""
        error.isHidden = true
        image.image = nil
        image.isHidden = true
        if let cachedData = imageCache.object(forKey: url.absoluteString as NSString) {
            image.image = UIImage(data: cachedData as Data)
            image.isHidden = false
        } else {
            loadNewImage(from: url, session: session)
        }
    }

    private func loadNewImage(from url: URL, session: SessionWrapper) {
        task?.cancel()
        task = session.wrappedDataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                guard let data = data, data.count > 0, error == nil, let image = UIImage(data: data) else {
                    self.error.text = "No image at \(url)"
                    self.error.isHidden = false
                    self.image.image = nil
                    self.image.isHidden = true
                    self.error.sizeToFit()
                    return
                }
                imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                self.error.text = ""
                self.error.isHidden = true
                self.image.image = image
                self.image.isHidden = false
            }
        }
        loader.startAnimating()
        task?.resume()
    }

    private func setUpErrorConstraints() {
        error.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor).isActive = true
        error.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
        error.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        error.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    private func setUpImageConstraints() {
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setUpLoaderConstraints() {
        loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

}
