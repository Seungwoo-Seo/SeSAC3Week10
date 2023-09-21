//
//  ViewController.swift
//  SeSAC3Week10
//
//  Created by 서승우 on 2023/09/19.
//

import Kingfisher
import SnapKit
import UIKit

class ViewController: UIViewController {

    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .green
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4 // 보통 3~5?
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()

    private let imageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()

    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureGesture()
        configureHierarchy()
        configureLayout()
        viewModel.request { [weak self] (url) in
            guard let self else {return}
            self.imageView.kf.setImage(with: url)
        }
    }

    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }

    // 따-닥
    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView.snp.size)
        }
    }



}

extension ViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}

struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable {
    let id: String
    let created_at: String
    let urls: PhotoURL
}

struct PhotoURL: Decodable {
    let full: String
    let thumb: String
}
