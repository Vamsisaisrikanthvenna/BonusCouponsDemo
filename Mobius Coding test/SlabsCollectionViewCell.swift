//
//  SlabsCollectionViewCell.swift
//  Mobius Coding test
//
//  Created by Adaps on 09/12/20.
//  Copyright © 2020 Task. All rights reserved.
//

import UIKit

class SlabsCollectionViewCell: UICollectionViewCell {

    //MARK:- Properties

    @IBOutlet weak var slabInstantCash: UILabel!
    @IBOutlet weak var slabBonusAmnt: UILabel!
    @IBOutlet weak var slabPurchaseAmnt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
