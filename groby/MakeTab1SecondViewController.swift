//
//  MakeTap1SecondViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1SecondViewController: UIViewController {
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1ThirdTableTableViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1ThirdTableTableViewController") as? MakeTab1ThirdTableTableViewController else { return }
        navigationController?.pushViewController(makeTab1ThirdTableTableViewController, animated: true)
    }
    
    @IBAction func tappedImgaeFetch(_ sender: UIButton) {
        let alertController: UIAlertController = UIAlertController()
        
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            print("camera")
        }
        
        let albumAction: UIAlertAction = UIAlertAction(title: "Album", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageAddButton: UIButton!
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        
        return picker
    } ()
    
    private var imageUrls: [NSURL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setCustomTitle("내용 작성")
        
        initializeView()
    }
    
    func initializeView() {
        imageAddButton.layer.borderWidth = 1
        imageAddButton.layer.borderColor = UIColor.whiteTwo.cgColor

        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 6
        flowLayout.minimumLineSpacing = 0
        
        let itemHeight = collectionView.frame.size.height
        let itemWidth = itemHeight
        
        print(itemHeight)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        collectionView.collectionViewLayout = flowLayout
    }
}

extension MakeTab1SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageUrl: NSURL = imageUrls[indexPath.item]
        
        OperationQueue().addOperation {
            guard let imageData: Data = try! Data.init(contentsOf: imageUrl as URL), let image: UIImage = UIImage(data: imageData) else {
                return
            }
            
            OperationQueue.main.addOperation {
                cell.imageView.image = image
            }
        }
        
        return cell
    }
}

extension MakeTab1SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let imageUrl = info[UIImagePickerControllerImageURL] as? NSURL else {
            return
        }
        
        imageUrls.append(imageUrl)
        
        collectionView.reloadData()
        
        dismiss(animated: false, completion: nil)
    }
}


