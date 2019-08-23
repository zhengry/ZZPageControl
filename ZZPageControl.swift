//
//  ZZPageControl.swift
//  Repay
//
//  Created by zry on 2019/8/5.
//  Copyright © 2019 ZRY. All rights reserved.
//

import UIKit

class ZZPageControl: UIView {

    public var currentImage:UIImage?
    public var currentImageSize:CGSize = .zero
    public var inactiveImage:UIImage?
    public var inactiveImageSize:CGSize = .zero
    public var itemSpace:CGFloat = 0
    
    var currentPage: NSInteger = 0 {
        didSet {
            if oldValue == currentPage {
                return
            }
            
            if currentPage < oldValue {// 向右拉伸
                UIView.animate(withDuration: 0.3, animations: {
                    for subview in self.subviews {
                        guard let dot = subview as? UIImageView else {
                            return
                        }
                        var dotFrame = dot.frame
                        if dot.tag == self.currentPage {
                            dotFrame.size.width = self.currentImageSize.width
                            dot.image = self.currentImage
                            dot.frame = dotFrame
                            
                        } else if dot.tag <= oldValue && dot.tag > self.currentPage {
                            dotFrame.origin.x += (self.currentImageSize.width - self.itemSpace)
                            dotFrame.size.width = self.inactiveImageSize.width
                            dot.image = self.inactiveImage
                            dot.frame = dotFrame
                        }
                    }
                })
                
            } else {// 向左拉伸
                UIView.animate(withDuration: 0.3, animations: {
                    for subview in self.subviews {
                        guard let dot = subview as? UIImageView else {
                            return
                        }
                        var dotFrame = dot.frame
                        if dot.tag == self.currentPage {
                            dotFrame.size.width = self.currentImageSize.width
                            dotFrame.origin.x -= self.currentImageSize.width - self.itemSpace
                            dot.image = self.currentImage
                            dot.frame = dotFrame
                            
                        } else if dot.tag > oldValue && dot.tag < self.currentPage {
                            dotFrame.origin.x -= self.currentImageSize.width - self.itemSpace
                            dot.frame = dotFrame
                            
                        } else if dot.tag == oldValue {
                            dotFrame.size.width = self.inactiveImageSize.width
                            dot.image = self.inactiveImage
                            dot.frame = dotFrame
                        }
                    }
                })
                
            }
            
        }
    }
    var numberOfPages: NSInteger = 0 {
        didSet {
            if self.numberOfPages == 0 {
                return
            }
            if self.subviews.count > 0 {
                for view in self.subviews {
                    view.removeFromSuperview()
                }
            }
            
            var dotX: CGFloat = 0;
            var dotW: CGFloat = inactiveImageSize.width;
            var image:UIImage?
            for i in 0..<numberOfPages {
                if i <= currentPage {
                    dotX = (inactiveImageSize.width + itemSpace) * CGFloat(i)
                } else {
                    dotX = (inactiveImageSize.width + itemSpace) * CGFloat(i - 1) + itemSpace + currentImageSize.width
                }
                
                if i == currentPage {
                    dotW = currentImageSize.width;
                    image = currentImage
                } else {
                    dotW = inactiveImageSize.width;
                    image = inactiveImage
                }
                
                let temp = UIImageView()
                temp.frame = CGRect(x: dotX, y: 0, width: dotW, height: inactiveImageSize.height)
                temp.image = image
                temp.tag = i
                addSubview(temp)
            }
            
        }
    }
}
