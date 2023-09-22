//
//  SearchViewController.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/21.
//

import SnapKit
import UIKit

final class SearchViewController: UIViewController {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    var list = Array(0...100)
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAttributes()
        configureHierarchy()
        configureLayout()
        configureDataSource()
    }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<SearchCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(itemIdentifier)번"
        }

        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView
        ) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])    // 어떤 데이터로(어떤 식별자로) 섹션을 관리할 것인지
        snapshot.appendItems(list)      // 어떤 데이터로(어떤 식별자로) 셀을 관리할 것인지
        dataSource.apply(snapshot)
    }

    func configureAttributes() {

    }

    func configureHierarchy() {
        view.addSubview(collectionView)
    }

    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        return layout
    }

}

//final class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//
//    let imageView = UIImageView()
//    let label = UILabel()
//    let button = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureAttributes()
//        configureHierarchy()
//        configureLayout()
//    }
//
//    func configureAttributes() {
//        scrollView.backgroundColor = .lightGray
//        contentView.backgroundColor = .white
//        imageView.backgroundColor = .yellow
//        label.text = "asdfasdfasdfasdf\nasdfasdfasdfasdadsfasdfasdfasdfasdfasdfa\nsfasdfasdfasdfasdfasdfas\ndfasdfasdfasdadsfasdfas\ndfasdfasdfasdfasfasdf\nasdfasdfasdfasdfasdfasdf\nasdfasdadsfasdfasdfasdfasdfasdfasfasdf\nasdfasdfasdfasdfasdfasdfasdfasdadsfasdfasd\nfasdfasdfasdfasfasdfasdfasdfasdfasdfasdfasdfas\ndfasdadsfasdfasdfasdfasdfasdfasfasdf"
//        label.numberOfLines = 0
//        label.backgroundColor = .black
//        label.textColor = .white
//        button.backgroundColor = .magenta
//
//        scrollView.bounces = false
//    }
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(imageView)
//        contentView.addSubview(button)
//        contentView.addSubview(label)
//    }
//
//    func configureLayout() {
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalToSuperview()
//            make.width.equalTo(scrollView.snp.width)
//        }
//
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(200)
//        }
//
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//
//}


//final class SearchViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        configureAttributes()
//        configureHierarchy()
//        configureLayout()
//    }
//
//    func configureAttributes() {
//        view.backgroundColor = .white
//        scrollView.backgroundColor = .lightGray
//        configureStackView()
//    }
//
//    func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    func configureLayout() {
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(70)
//        }
//    }
//
//    func configureStackView() {
//        let label1 = UILabel()
//        label1.text = "hi~"
//        label1.backgroundColor = .orange
//        label1.textColor = .white
//        stackView.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.text = "bye~"
//        label2.textColor = .white
//        label2.backgroundColor = .orange
//        stackView.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "안녕하세요"
//        label3.textColor = .white
//        label3.backgroundColor = .orange
//        stackView.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "잘가~"
//        label4.textColor = .white
//        label4.backgroundColor = .orange
//        stackView.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "안녕안녕ㅇ~"
//        label5.textColor = .white
//        label5.backgroundColor = .orange
//        stackView.addArrangedSubview(label5)
//
//        stackView.backgroundColor = .clear
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
//        stackView.distribution = .fillProportionally
//        stackView.spacing = 8
//    }
//
//}
