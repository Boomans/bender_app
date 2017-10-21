//
//  FirstViewController.swift
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
    
    var categories: [NetworkManager.Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkManager.shared.getCategories(success: { (categories) in
            self.categories = categories
            self.collectionView.reloadData()
        }) { (error) in
            // Error
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MuseumToCollection", sender is CategoryCollectionCell {
            let sender = sender as! CategoryCollectionCell
            segue.destination.navigationItem.title = sender.titleLabel.text
            (segue.destination as! CollectionController).loadPicturesForCollection(title: sender.titleLabel.text!)
        }
    }

    // MARK: Collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categories.count
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        
        cell.titleLabel.text = categories[indexPath.row].title
        
        cell.imageView.image = nil
        cell.imageView.af_setImage(withURL: categories[indexPath.row].imageURL)
        
        return cell
    }
}
