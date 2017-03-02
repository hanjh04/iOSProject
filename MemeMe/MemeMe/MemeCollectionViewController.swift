//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 25..
//  Copyright © 2017년 udacity. All rights reserved.

import UIKit
import Foundation

class MemeCollectionViewController: UICollectionViewController{

    
    // MARK: outlets
    
    @IBOutlet var cView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    // MARK: properties
    
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    // MARK: life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cView.reloadData()
        if appDelegate.memes.count == 0{
            performSegue(withIdentifier: "memeEditor", sender: nil)
        }
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }

    
    // MARK: 컬렉션 뷰 설정
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let memes = self.appDelegate.memes
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.appDelegate.memes[indexPath.row]
        
        cell.memedImage.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = appDelegate.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }

}
