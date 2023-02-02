//
//  NewProductViewController.swift
//  STORE
//
//  Created by chuottp on 14/01/2023.
//

import UIKit

class NewProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var newProducts : Products = []
    
    @IBOutlet weak var cltNewProductView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewProductsFromAPI()
        cltNewProductView.delegate = self
        cltNewProductView.dataSource = self
        // Do any additional setup after loading the view.

        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let screenWith = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWith/2-10, height: 278)
        cltNewProductView.collectionViewLayout = layout
            
    }
    
    func getNewProductsFromAPI() {

        ProductAPI.init().getNewProducts { productsResponse in
                self.newProducts = productsResponse
                self.cltNewProductView.reloadData()
            }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return newProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cltNewProductView.dequeueReusableCell(withReuseIdentifier: "NewProductIdentifier", for: indexPath)
        
        let currentProduct = newProducts[indexPath.row]
        
        let lblTag = cell.viewWithTag(5) as! UILabel
        lblTag.layer.cornerRadius = 10
        lblTag.layer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 10)
        
        let imgPicture = cell.viewWithTag(1) as! UIImageView
        imgPicture.image = UIImage(named: "\(currentProduct.anhSANPham)")
        imgPicture.layer.cornerRadius = 5
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        tapGestureRecognizer.name = "\(currentProduct.maSANPham)"
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(tapGestureRecognizer)
        
        let lblTitle = cell.viewWithTag(2) as! UILabel
                lblTitle.text = currentProduct.tenSANPham
        
        let lblDescription = cell.viewWithTag(3) as! UILabel
        lblDescription.text = "\(currentProduct.giaTienSANPham)"
        
        return cell
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
