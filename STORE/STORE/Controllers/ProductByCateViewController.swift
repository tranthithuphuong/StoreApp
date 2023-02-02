//
//  ProductByCateViewController.swift
//  STORE
//
//  Created by chuottp on 18/01/2023.
//

import UIKit

class ProductByCateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var productData : Products = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblProductCateView.dequeueReusableCell(withIdentifier: "ProductCateIdentifier", for: indexPath)
        let currentData = productData[indexPath.row]
        
        let imgPicture = cell.viewWithTag(1) as! UIImageView
        imgPicture.image = UIImage(named: "\(currentData.anhSANPham)")
        
        let lblName = cell.viewWithTag(2) as! UILabel
        lblName.text = currentData.tenSANPham
        
        let lblPrice = cell.viewWithTag(3) as! UILabel
        lblPrice.text = "\(currentData.giaTienSANPham)"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.name = "\(currentData.maSANPham)"
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    

    @IBOutlet weak var tblProductCateView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let categoryId = UserDefaults.standard.string(forKey: "Cate") ?? "DM1"
        callProduct(cateId: categoryId)
        
        tblProductCateView.delegate = self
        tblProductCateView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func callProduct(cateId: String){

        ProductAPI.init().getProductByCate(cateId: cateId){
                productsReponseData in
               
                self.productData = productsReponseData
                self.tblProductCateView.reloadData()
            
            }
    }

    @objc func imageTapped(sender: UITapGestureRecognizer) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"DetailProduct") as? DetailViewController
        vc!.categoryId = sender.name
        vc? .modalPresentationStyle = .overFullScreen
        self.present(vc!,animated: true)
        
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
