//
//  GeminiViewController.swift
//  customTabbarNoSB
//
//  Created by Samet Korkmaz on 8.09.2024.
//

import UIKit

class GeminiViewController: UIViewController {

    private let backButtom: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrowshape.backward"), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .lightGray
        btn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        view.addSubview(backButtom)
        backButtom.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButtom.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            backButtom.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            backButtom.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
        ])
    }
    
    @objc func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }

}
#Preview(){
    GeminiViewController()
}
