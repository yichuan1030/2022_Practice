//
//  myTableViewCell.swift
//  simpleMVVM
//
//  Created by raymondwang on 2022/4/2.
//

import Foundation
import UIKit
import SwiftUI


class myTableViewCell : UITableViewCell {
    
    var cellData : tableViewCellData? {
        didSet {
            title = cellData?.title
            content = cellData?.content
            guard let imgUrl = cellData?.img,
                  let url = URL(string: imgUrl),
                  let imgData = try? Data(contentsOf: url) else { return }
//            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imgView.image = UIImage(data: imgData)
        }
    }
    
    var title: String? {
        didSet {
            titleLB.text = title
        }
    }
    var content: String? {
        didSet {
            contentLB.text = content
        }
    }
    lazy var img: UIImage = UIImage() {
        didSet {
            imgView.image = img
        }
    }
    
    lazy var titleLB : UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.blue
        lb.adjustsFontSizeToFitWidth = true
        self.addSubview(lb)
        return lb
    }()
    
    lazy var contentLB : UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.numberOfLines = 0
        lb.adjustsFontSizeToFitWidth = true
        self.addSubview(lb)
        return lb
    }()
    
    lazy var imgView : UIImageView = {
        let view = UIImageView()
        self.addSubview(view)
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect = self.frame
        let LR_Padding : CGFloat = 8.0
        let TB_Padding : CGFloat = 4.0
        let hUnit = (rect.height-TB_Padding*3) / 4
        let imgW = rect.height - 2 * TB_Padding
        imgView.frame = CGRect(x: LR_Padding, y: TB_Padding, width: imgW, height: imgW)
        titleLB.frame = CGRect(x: imgView.frame.maxX + LR_Padding,
                               y: TB_Padding,
                               width: rect.width - imgView.frame.maxX - 2*TB_Padding,
                               height: hUnit * 3)
        contentLB.frame = CGRect(x: titleLB.frame.minX, y: titleLB.frame.maxY + TB_Padding,
                                 width: titleLB.frame.width, height: hUnit)
        
        
    }
    
    
}
