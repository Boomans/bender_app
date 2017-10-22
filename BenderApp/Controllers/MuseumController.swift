//
//  MuseumController.swift
//  BenderApp
//
//  Created by bestK1ng on 20/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MuseumController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collections: [NetworkManager.Collection] = []
    var categories: [NetworkManager.Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkManager.shared.getCollections(success: { (collections) in
            self.collections = collections
            self.collectionView.reloadData()
        }) { (error) in
            // Error
        }
        
        NetworkManager.shared.getCategories(success: { (categories) in
            self.categories = categories
            self.collectionView.reloadData()
        }) { (error) in
            // Error
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MuseumToCollection", sender is CollectionCell {
            let sender = sender as! CollectionCell
            segue.destination.navigationItem.title = sender.titleLabel.text
            (segue.destination as! CollectionController).loadPicturesForCollection(title: sender.titleLabel.text!)
        } else if segue.identifier == "MuseumToCategory", sender is CategoryCell {
            let sender = sender as! CategoryCell
            segue.destination.navigationItem.title = sender.titleLabel.text
            (segue.destination as! CollectionController).loadPicturesForCategory(title: sender.titleLabel.text!)
        }
    }

    // MARK: Collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView = UICollectionReusableView()
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as! CollectionViewHeader
            
            switch indexPath.section {
            case 0:
                headerView.titleLabel.text = "Коллекции"
            case 1:
                headerView.titleLabel.text = "Категории"
            default:
                break
            }
            
            reusableView = headerView
        }
        
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return collections.count
        case 1:
            return categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
            
            cell.titleLabel.text = collections[indexPath.row].title
            
            cell.imageView.image = nil
            cell.imageView.af_setImage(withURL: collections[indexPath.row].imageURL)
            
            return cell
            
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            
            cell.titleLabel.text = categories[indexPath.row].title
            
            cell.imageView.image = nil
            cell.imageView.af_setImage(withURL: categories[indexPath.row].imageURL)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}
