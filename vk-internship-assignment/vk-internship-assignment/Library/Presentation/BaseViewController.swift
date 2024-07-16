//
//  BaseViewController.swift
//  vk-internship-assignment
//
//  Created by Artem Tebenkov on 16.07.2024.
//

import UIKit

class BaseViewController: UIViewController {

    /// Storing strong presenter reference to prevent module breaking
    private var presenterRefHolder: AnyObject?

    var onViewDidLoad: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        onViewDidLoad?()
    }

    func addPresenterRef(_ presenterRefHolder: AnyObject) {
        self.presenterRefHolder = presenterRefHolder
    }
}
