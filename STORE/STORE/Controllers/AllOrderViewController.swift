//
//  AllOrderViewController.swift
//  STORE
//
//  Created by chuottp on 02/02/2023.
//

import UIKit

class AllOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var orders: Ordered = []
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblOrderView.dequeueReusableCell(withIdentifier: "OrderItemIdentifier", for: indexPath)
        
        let currentData = orders[indexPath.row]
        
        let lblID = cell.viewWithTag(1) as! UILabel
        lblID.text = "ID: \(currentData.maDonHang)"
        
        let lblState = cell.viewWithTag(2) as! UILabel
        lblState.text = currentData.trangThai
        
        let lblPrice = cell.viewWithTag(3) as! UILabel
        lblPrice.text = "Total: \(currentData.tongTien) VND"
        
        let lblTime = cell.viewWithTag(4) as! UILabel
        lblTime.text = "create at: " + currentData.taoLuc
        
        let btnViewDetail = cell.viewWithTag(5) as! UIButton
        btnViewDetail.layer.name = "\(currentData.maDonHang)"
        btnViewDetail.addTarget(self, action: #selector(showDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    

    @IBOutlet weak var tblOrderView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CallAPI()
        print("HEHE")
        tblOrderView.delegate = self
        tblOrderView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @objc func showDetail(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"OrderDetailView") as? OrderDetailViewController
        vc!.orderID = sender.layer.name ?? ""
        vc? .modalPresentationStyle = .overFullScreen
        self.present(vc!,animated: true)
        
    }
    
    func CallAPI() {
        OrderAPI.init().getOrder(Id: 1) { ordersRespone in
            self.orders = ordersRespone
            print(self.orders)
            self.tblOrderView.reloadData()
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

//Fake ID người dùng

struct User: Encodable {
    var ma_nguoi_dung: Int;
}
