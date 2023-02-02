//
//  CartViewController.swift
//  STORE
//
//  Created by chuottp on 29/01/2023.
//

import UIKit

class CartViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource{
    //var products = try? JSONDecoder().decode(Products.self, from: UserDefaults.standard.data(forKey: "saveData")!)
    var products: Products = [];
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        
        return cell
    }
    

    
    @IBOutlet weak var tblCartView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getProductsFromAPI()
        tblCartView.delegate = self
        tblCartView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func getProductsFromAPI() {

        ProductAPI.init().getProducts { productsResponse in
                self.products = productsResponse
                self.tblCartView.reloadData()
            }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
