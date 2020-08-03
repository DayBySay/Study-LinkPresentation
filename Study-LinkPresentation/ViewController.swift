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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let provider = LPMetadataProvider()
        let url = URL(string: "https://www.apple.com/ipad/")!
        
        provider.startFetchingMetadata(for: url) { [weak self] (metadata, error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                guard let metadata = metadata else { return }
                let lpview = LPLinkView(metadata: metadata)
                lpview.frame = CGRect(x: 100, y: 100, width: 300, height: 200)
                self?.view.addSubview(lpview)
            }
        }
        
    }
}

