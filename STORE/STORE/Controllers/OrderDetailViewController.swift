//
//  OrderDetailViewController.swift
//  STORE
//
//  Created by chuottp on 02/02/2023.
//

import UIKit

class OrderDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var orderID: String = "";
    var data: OrderDetails = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblOrderDetailView.dequeueReusableCell(withIdentifier: "OrderDetailIdentifier", for: indexPath)
        
        let currentData = data[indexPath.row]
        
        let imgPicture = cell.viewWithTag(4) as! UIImageView
        imgPicture.image = UIImage(named: "\(currentData.anhSANPham)")
        
        let lblName = cell.viewWithTag(2) as! UILabel
        lblName.text = currentData.tenSANPham
        
        let lblPrice = cell.viewWithTag(3) as! UILabel
        lblPrice.text = "\(currentData.giaTien) VND"
        
        
        return cell
    }
    

    
    
    @IBOutlet weak var tblOrderDetailView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
        
        tblOrderDetailView.delegate = self
        tblOrderDetailView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func callAPI() {
        let id = Int(orderID) as Any as! Int
        OrderAPI.init().getOrderDetail(Id: id) { orderDetailsResponse in
            self.data = orderDetailsResponse
            self.tblOrderDetailView.reloadData()
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"TabBarUI")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
        
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
