//
//  ShopViewController.swift
//  STORE
//
//  Created by chuottp on 14/01/2023.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var categories : Categories = []
    var categoryID = UserDefaults.standard.string(forKey: "Cate") ?? "DM1"
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cltCategoryView.dequeueReusableCell(withReuseIdentifier: "CategoryIdentifier", for: indexPath)
        
        let currentCategory = categories[indexPath.row]
        
        let btnTitle = cell.viewWithTag(1) as! UIButton
        btnTitle.setTitle("\(currentCategory.tenDanhMuc)", for: .normal)
        btnTitle.layer.name = currentCategory.maDanhMuc
        btnTitle.layer.cornerRadius = 15
        
        if(currentCategory.maDanhMuc == categoryID) {
            btnTitle.layer.backgroundColor = UIColor.red.cgColor
            btnTitle.tintColor = UIColor.white
        }
        btnTitle.addTarget(self, action: #selector(changeCate(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func changeCate(_ sender: UIButton) {
        UserDefaults.standard.set(sender.layer.name!, forKey: "Cate")
        
        let vc2 = storyboard!.instantiateViewController(withIdentifier:"ShopView") as? ShopViewController
        vc2? .modalPresentationStyle = .overFullScreen
        self.present(vc2!,animated: false)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let vc = storyboard.instantiateViewController(withIdentifier:"ProductByCategory") as? ProductByCateViewController
        //vc!.categoryId = categoryID
        //vc!.ifChange(passVariable: sender.layer.name!)
    }


    
    @IBAction func btnBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"TabBarUI")
        vc .modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
        
    }
    @IBOutlet weak var cltCategoryView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //vc!.callProduct(cateId: categoryID)
        getCategoriesFromAPI()
        
        cltCategoryView.delegate = self
        cltCategoryView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let screenWith = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWith/2-10, height: 80)
        cltCategoryView.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }
    
    func getCategoriesFromAPI() {
        CategoryAPI.init().getCategories { categoriesResponse in
            self.categories = categoriesResponse
            self.cltCategoryView.reloadData()
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
