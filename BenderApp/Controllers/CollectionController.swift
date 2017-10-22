//
//  CollectionController.swift
//  BenderApp
//
//  Created by a.belkov on 22/10/2017.
//  Copyright © 2017 bestK1ng. All rights reserved.
//

import UIKit

class CollectionController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var pictures: [NetworkManager.Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadPicturesForCollection(title: String) {
        
        NetworkManager.shared.getPicturesForCollection(title: title, success: { (pictures) in
            self.pictures = pictures
            self.collectionView.reloadData()
        }, failure: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionToPicture", sender is CollectionCell {
            let sender = sender as! CollectionCell
            
            let indexPath = self.collectionView.indexPath(for: sender)
            let picture = pictures[(indexPath?.row)!]
            
            (segue.destination as! PictureController).loadPictureInfo(id: picture.id)
        }
    }
    
    // MARK: Collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CollectionCell
        
        cell.imageView.image = nil
        cell.imageView.af_setImage(withURL: pictures[indexPath.row].imageURL)
        
        return cell
    }
}
