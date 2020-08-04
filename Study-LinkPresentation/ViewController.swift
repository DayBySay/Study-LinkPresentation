//
//  ViewController.swift
//  Study-LinkPresentation
//
//  Created by Takayuki Sei on 2020/07/30.
//  Copyright © 2020 Takayuki Sei. All rights reserved.
//

import UIKit
import LinkPresentation

class ViewController: UIViewController {
    private let repository = OGPRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ogpUrl = URL(string: "https://www.apple.com/ipad/")!
        let ogpFrame = CGRect(x: 100, y: 100, width: 300, height: 200)
        addOGPView(url: ogpUrl, frame: ogpFrame)
        
        let twUrl = URL(string: "https://twitter.com/tion_low")!
        let twFrame = CGRect(x: 100, y: 300, width: 300, height: 200)
        addOGPView(url: twUrl, frame: twFrame)
    }
    
    private func addOGPView(url: URL, frame: CGRect) {
        repository.ogpMetadata(url: url) { [weak self] (metadata) in
            DispatchQueue.main.async {
                let lpview = LPLinkView(metadata: metadata)
                lpview.frame = frame
                self?.view.addSubview(lpview)
            }
        }
    }
}
