//
//  ViewController.swift
//  Mobius Coding test
//
//  Created by Adaps on 09/12/20.
//  Copyright © 2020 Task. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Properties
    
    var couponsTableView = UITableView()
    var couponsList = BonusCouponsList()
    
    //MARK:-Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.getCoupons()
        // Do any additional setup after loading the view.
    }

    private func setUpTableView(){
        self.couponsTableView.frame = self.view.bounds
        self.couponsTableView.separatorStyle = .none
        self.view.addSubview(couponsTableView)
        self.couponsTableView.register(UINib(nibName: "CouponsTableViewCell", bundle: nil), forCellReuseIdentifier: "CouponsTableViewCell")
        self.couponsTableView.delegate = self
        self.couponsTableView.dataSource = self
    }
    
    private func getCoupons(){
        if CheckInternet.Connection(){
            self.showLoader()
            APIService.shared.GET(endpoint: APIService.Endpoint.getBonusCouponList)     {
                (result: Result<[BonosCouponModel], APIService.APIError>) in
                self.hideLoader()
                switch result {
                case let .success(response):
                    self.couponsList = response
                    DispatchQueue.main.async {
                        self.couponsTableView.reloadData()
                    }
                case let .failure(error):
                    print(error)
                    break
                }
            }
        }else{
            ShowAlertPopup(msg: "No Internet Connection", title: "Make sure your device is connected to the internet.")
        }
        
    }
    func ShowAlertPopup(msg:String, title:String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        {
            (result : UIAlertAction) -> Void in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
}
//MARK:-Tableview delegates implementation

extension ViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.couponsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponsTableViewCell", for: indexPath) as! CouponsTableViewCell
        cell.item = self.couponsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let slabs = self.couponsList[indexPath.row].slabs
        return CGFloat(((slabs.count * 33) + 250))
    }
    
    
}

