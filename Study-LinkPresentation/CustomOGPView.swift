//
//  CustomOGPView.swift
//  Study-LinkPresentation
//
//  Created by Takayuki Sei on 2020/08/04.
//  Copyright © 2020 Takayuki Sei. All rights reserved.
//

import UIKit
import LinkPresentation

class CustomOGPView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var url: UILabel!
    
    func setMetadata(metadata: LPLinkMetadata) {
        title.text = metadata.title
        url.text = metadata.url?.absoluteString
        
        if metadata.imageProvider?.canLoadObject(ofClass: URL.self) ?? false {
            let url = metadata.imageProvider?.loadObject(ofClass: URL.self, completionHandler: { (url, error) in
                print(url)
            })
        }
    }
}
