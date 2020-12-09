//
//  CouponsTableViewCell.swift
//  Mobius Coding test
//
//  Created by Adaps on 09/12/20.
//  Copyright © 2020 Task. All rights reserved.
//

import UIKit

class CouponsTableViewCell:TableViewCell {
    
    //MARK:- Properties
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ribbonMsgLbl: UILabel!
    var slabsArr = [Slab]()
    var myMutableString = NSMutableAttributedString()
    @IBOutlet weak var wageBonusExpiryLbl: UILabel!
    @IBOutlet weak var wagesLbl: UILabel!
    @IBOutlet weak var slabsCollectionView: UICollectionView!
    @IBOutlet weak var depositAmount: UILabel!
    @IBOutlet weak var showDetailsBtn: UIButton!
    @IBOutlet weak var validityLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var codeLbl: UILabel!
    
    //MARK:- Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
        drawCircleInsideView(view: mainView, count: 25)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setUpCollectionView(){
        self.slabsCollectionView.register(UINib(nibName: "SlabsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SlabsCollectionViewCell")
        self.slabsCollectionView.delegate = self
        self.slabsCollectionView.dataSource = self
    }
    
    //MARK:- Implementation
    
    override func configure(_ item: Any?) {
        guard let couponObject = item as? BonosCouponModel else{return}
        let rupeeSymbol = getSymbol(forCurrencyCode: "INR")
        self.codeLbl.text = couponObject.code
        self.ribbonMsgLbl.text = couponObject.ribbonMsg
        self.depositAmount.text = "\(rupeeSymbol ?? "") 500"
        let validity = convertDateFormater(couponObject.validUntil ?? "")
        self.validityLbl.text = "Valid till \(validity)"
        let wagesLblValue = "For every \(rupeeSymbol ?? "")\(couponObject.wagerToReleaseRatioNumerator) bet \(rupeeSymbol ?? "")\(couponObject.wagerToReleaseRatioDenominator) will be \nreleased from the bonus amount"
        let wagesAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: wagesLblValue)
        wagesAttributedString.setColorForText(textForAttribute: "\(rupeeSymbol ?? "")\(couponObject.wagerToReleaseRatioNumerator)", withColor: UIColor.yellow)
        wagesAttributedString.setColorForText(textForAttribute: "\(rupeeSymbol ?? "")\(couponObject.wagerToReleaseRatioDenominator)", withColor: UIColor.yellow)
        self.wagesLbl.attributedText = wagesAttributedString
        
        let wageExpValue = "Bonus expiry \(rupeeSymbol ?? "")\(couponObject.wagerBonusExpiry) \nfrom the issue"
        let expAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: wageExpValue)
        expAttributedString.setColorForText(textForAttribute: "\(rupeeSymbol ?? "")\(couponObject.wagerBonusExpiry)", withColor: UIColor.yellow)
        self.wageBonusExpiryLbl.attributedText = expAttributedString
        
        self.slabsArr = couponObject.slabs
        let maxWageredPercent = slabsArr.map { $0.wageredPercent }.max()
        let maxOtcPercent = slabsArr.map { $0.otcPercent }.max()
        
        let maxWageredValue = slabsArr.map { $0.wageredMax }.max()
        let maxOtcValue = slabsArr.map { $0.otcMax }.max()
        self.discountLbl.text = "Get \((maxOtcPercent ?? 0 ) + (maxWageredPercent ?? 0))% upto \(rupeeSymbol ?? "")\((maxOtcValue ?? 0) + (maxWageredValue ?? 0))"
        
        DispatchQueue.main.async {
            self.slabsCollectionView.reloadData()
        }
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM,yyyy hh:mm a"
        return  dateFormatter.string(from: date!)
    }
    
    func drawCircleInsideView(view: UIView, count: Int){
        let halfSize:CGFloat = 10
        let desiredLineWidth:CGFloat = 5
        var i = 0
        var lastPosition = 0
        while i <= count {
            i = i + 1
            let circlePath = UIBezierPath(
                arcCenter: CGPoint(x:halfSize + (CGFloat(i) * halfSize*2) - 35,y:halfSize - 10),
                radius: 5,
                startAngle: CGFloat(180.0).degreesToRadians,
                endAngle:CGFloat(0.0).degreesToRadians,
                clockwise: false)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.fillColor = #colorLiteral(red: 0.95556885, green: 0.7713528275, blue: 0.6811130047, alpha: 1)
            shapeLayer.strokeColor = #colorLiteral(red: 0.95556885, green: 0.7713528275, blue: 0.6811130047, alpha: 1)
            shapeLayer.lineWidth = desiredLineWidth
            view.layer.addSublayer(shapeLayer)
            lastPosition = lastPosition + 2
        }
    }
}
extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}

extension CouponsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.slabsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlabsCollectionViewCell", for: indexPath) as! SlabsCollectionViewCell
        let slabObject = slabsArr[indexPath.row]
        let rupeeSymbol = getSymbol(forCurrencyCode: "INR")
        cell.slabPurchaseAmnt.text = "<\(slabObject.max)"
        if indexPath.row == 1{
            cell.slabPurchaseAmnt.text = ">=\(slabObject.min) & <\(slabObject.max)"
        }else if indexPath.row == 2{
            cell.slabPurchaseAmnt.text = ">=\(slabObject.min)"
        }
        cell.slabBonusAmnt.text = "\(slabObject.wageredPercent)% (Max.\(rupeeSymbol ?? "")\(slabObject.wageredMax))"
        cell.slabInstantCash.text = "\(slabObject.otcPercent)% (Max.\(rupeeSymbol ?? "")\(slabObject.otcMax))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.slabsCollectionView.frame.size.width, height: 30)
    }
    
}
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
