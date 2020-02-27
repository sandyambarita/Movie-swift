//
//  ReviewCell.swift
//  Movie
//
//  Created by sandy ambarita on 27/02/20.
//  Copyright © 2020 Fundtastic. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var viewReview: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewReview.layoutIfNeeded()
        viewReview.layer.masksToBounds = false
        viewReview.layer.borderWidth = 1.0
        viewReview.layer.borderColor = UIColor.white.cgColor
        viewReview.layer.shadowColor = UIColor.lightGray.cgColor
        viewReview.layer.shadowRadius = 5
        viewReview.layer.shadowOpacity = 1
        viewReview.layer.shadowOffset = CGSize(width:2, height: 0)
    }
    
    func configureCell(data: MovieReviewData) {
        lblAuthor.text = ": \(data.author ?? "")"
        lblContent.text = ": \(data.content ?? "")"
        lblUrl.text = ": \(data.url ?? "")"
    }

}
