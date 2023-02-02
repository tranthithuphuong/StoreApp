//
//  OrderViewController.swift
//  STORE
//
//  Created by chuottp on 02/02/2023.
//

import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createOrder()
        // Do any additional setup after loading the view.
    }
    
    func createOrder () {
        let data = UserDefaults.standard.data(forKey: "saveCart")
                let saveData = try? JSONDecoder().decode(Order.self, from: data!)
                print(saveData!)
        
        OrderAPI.init().createOrder(ordered: saveData!)
    }

    @IBAction func btnContinue(_ sender: Any) {
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
