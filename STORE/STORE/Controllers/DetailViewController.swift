//
//  DetailViewController.swift
//  STORE
//
//  Created by chuottp on 18/01/2023.
//

import UIKit

class DetailViewController: UIViewController {
    var product: Products = []
    var categoryId: String?
    
    @IBOutlet weak var imgDetailProduct: UIImageView!
    
    @IBOutlet weak var lblDetailName: UILabel!
    @IBOutlet weak var lblDetailPrice: UILabel!
        
    @IBOutlet weak var btnPrevease: UIButton!
    @IBOutlet weak var btnAddItem: UIButton!
    
    @IBOutlet weak var lblAlert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnPrevease.layer.backgroundColor = UIColor.white.cgColor
        btnPrevease.tintColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(product.isEmpty) {
            callAPI(id: "\(categoryId!)")
            } else {
                print(product)
                imgDetailProduct.image = UIImage(named: "\(product[0].anhSANPham)")
                lblDetailName.text = product[0].tenSANPham
                lblDetailPrice.text = "\(product[0].giaTienSANPham) VND"
                                   

            }
    }

    func callAPI(id: String) {
        ProductAPI.init().getProductById(Id: "\(id)") {  productsRespone in
                   self.product = productsRespone
                    self.viewWillAppear(true)
        }
    
    }

    @IBAction func btnNavigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"TabBarUI")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    
    
    @IBAction func addItemToCart(_ sender: Any) {
        let data = UserDefaults.standard.data(forKey: "saveData")
        if(data == nil) {
            UserDefaults.standard.set(try? JSONEncoder().encode(self.product), forKey: "saveData")
        } else {
            var saveData = try? JSONDecoder().decode(Products.self, from: data!) //truyển dữ liệu trong userdefault từ chuỗi JSON sang ký tự code
                      //gắn dữ liệu mới lấy vào mảng
            saveData!.append(product[0])
            UserDefaults.standard.set(try? JSONEncoder().encode(saveData!), forKey: "saveData")
            
        }
        lblAlert.text = "Thêm vào giỏ hàng thành công"
        
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
