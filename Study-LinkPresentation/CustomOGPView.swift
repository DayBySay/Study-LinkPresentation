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
        
        if let provider = metadata.imageProvider {
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) {(image, error) in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async { [weak self] in
                            self?.imageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
    }
}
