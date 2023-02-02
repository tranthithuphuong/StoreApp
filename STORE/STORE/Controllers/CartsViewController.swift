//
//  CartsViewController.swift
//  STORE
//
//  Created by chuottp on 29/01/2023.
//

import UIKit

class CartsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var products : Products = []
    var total: Int = 0;
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lblCountItem.text = "Số lượng: \(products.count)"
        if(products.count == 0) {
            lblAlert.text = "Giỏ Hàng Trống"
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCartView.dequeueReusableCell(withIdentifier: "CartItemIdentifier", for: indexPath)
        
        let currentProduct = products[indexPath.row]
        
        let imgPicture = cell.viewWithTag(1) as! UIImageView
        imgPicture.image = UIImage(named: "\(currentProduct.anhSANPham)")
        
        let lblName = cell.viewWithTag(2) as! UILabel
        lblName.text = currentProduct.tenSANPham
        
        let lblPrice = cell.viewWithTag(3) as! UILabel
        lblPrice.text = "\(currentProduct.giaTienSANPham)"
        
        let btnDelete = cell.viewWithTag(4) as! UIButton
        btnDelete.layer.name = "\(indexPath.row)"
        btnDelete.addTarget(self, action: #selector(deleteItem(_:)), for: .touchUpInside)
        return cell
    }
    

    @IBOutlet weak var tblCartView: UITableView!
    
    @IBOutlet weak var lblCountItem: UILabel!
    
    @IBOutlet weak var txtSaleCode: UITextField!
    
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAlert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        callData()
        
        tblCartView.delegate = self
        tblCartView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func totalCost(productList: Products) {
        lblTotal.text = "Total: 0 VND"
        total = 0
        for (index, item) in products.enumerated() {
            total = total + item.giaTienSANPham
            if((index+1) == products.count) {
                lblTotal.text = "Total: \(total) VND"
            }
            
        }
    }

    func callData() {
        let data = UserDefaults.standard.data(forKey: "saveData")
        let saveData = try? JSONDecoder().decode(Products.self, from: data!)
        products = saveData!
        totalCost(productList: saveData!)
        tblCartView.reloadData()
    }
    
    
    @IBAction func btnCheckSaleCode(_ sender: Any) {
    }
    
    @objc func deleteItem(_ sender: UIButton) {
        let data = UserDefaults.standard.data(forKey: "saveData")
        let saveData = try? JSONDecoder().decode(Products.self, from: data!)
        var newData : Products = []
        var index : Int = 0
        for (item) in saveData! {
            
            if("\(index)" != sender.layer.name) {
                newData.append(item)
            }
            index += 1
        }
        
        UserDefaults.standard.set(try? JSONEncoder().encode(newData), forKey: "saveData")
        callData()
    }
    
    @IBAction func createOrder(_ sender: Any) {
        if(lblTotal.text == "Total: 0") {
            return
        } else {
            let data = UserDefaults.standard.data(forKey: "saveData")
            let saveData = try? JSONDecoder().decode(Products.self, from: data!)
            let order =  Order(ma_nguoi_dung: 1, tong_tien: total, data: saveData!)
            UserDefaults.standard.set(try? JSONEncoder().encode(order), forKey: "saveCart")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier:"OrderView")
            vc .modalPresentationStyle = .overFullScreen
            self.present(vc,animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue:, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


struct Order: Codable{
    var ma_nguoi_dung:Int;
    var tong_tien:Int;
    var data:Products;
}
