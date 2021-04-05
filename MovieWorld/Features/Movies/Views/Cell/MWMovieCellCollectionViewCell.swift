//
//  MWMovieCellCollectionViewCell.swift
//  MovieWorld
//
//  Created by Nadya Khrol on 01.04.2021.
//

import UIKit

class MWMovieCellCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "MWMovieCellCollectionViewCell"

    private let edgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 5, right: 10)

    //MARK: - qui variable

    private(set) lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.backgroundColor = .darkGray
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.tintColor = .black
            label.font = UIFont.systemFont(ofSize: 17)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.tintColor = .lightGray
            label.font = UIFont.systemFont(ofSize: 12)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    //MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.intView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func intView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubviews([
                                        self.imageView,
                                        self.titleLabel,
                                        self.dateLabel])
    }
    //MARK: - constraints

    override func updateConstraints() {
        self.imageView.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).inset(self.edgeInsets.top)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }

        self.dateLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).inset(self.edgeInsets.top)
            make.left.right.bottom.equalToSuperview().inset(self.edgeInsets)

        }
        super.updateConstraints()
    }
    func set(title: String, date: Date) {
        self.titleLabel.text = title
        self.dateLabel.text = date.toString()

        self.setNeedsUpdateConstraints()
    }
}

