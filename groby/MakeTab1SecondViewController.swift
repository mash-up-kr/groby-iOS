//
//  MakeTab1SecondViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit

class MakeTab1SecondViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.delegate = self
        }
    }

    @IBAction func tappedImgaeFetch(_ sender: UIButton) {
        let alertController: UIAlertController = UIAlertController()

        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { [weak self] (_ : UIAlertAction) in
            guard let `self` = self else {
                return
            }
            self.present(self.imagePickerFromCamera, animated: true, completion: nil)
        }

        let albumAction: UIAlertAction = UIAlertAction(title: "Album", style: UIAlertActionStyle.default) { [weak self] (_ : UIAlertAction) in
            guard let `self` = self else {
                return
            }
            self.present(self.imagePickerFromLibrary, animated: true, completion: nil)
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)

        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

//    @IBOutlet weak var editor: RichEditorView!
//    lazy var toolbar: RichEditorToolbar = {
//        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
//        toolbar.options = [RichEditorDefaultOption.image]
//        return toolbar
//    }()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    @IBOutlet weak var imageAddButton: UIButton!

    private lazy var imagePickerFromCamera: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()

        picker.sourceType = .camera
        picker.delegate = self

        return picker
    } ()

    private lazy var imagePickerFromLibrary: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()

        picker.sourceType = .photoLibrary
        picker.delegate = self

        return picker
    } ()

    private var imageUrls: [URL] = []

    override func viewDidLoad() {
        super.viewDidLoad()

//        editor.placeholder = "내용"
//        toolbar.editor = editor
//        editor.inputAccessoryView = toolbar
//        toolbar.delegate = self

        navigationItem.setCustomTitle("내용 작성")

        initializeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CommonDataManager.share.imageURLs = nil
    }
    
    private func initializeView() {
        imageAddButton.layer.borderWidth = 1
        imageAddButton.layer.borderColor = UIColor.whiteTwo.cgColor

        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 6
        flowLayout.scrollDirection = .horizontal

        let itemHeight = collectionView.frame.size.height
        let itemWidth = itemHeight

        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        collectionView.collectionViewLayout = flowLayout
    }

    @objc private func tappedClearImage(sender: UIButton) {
        let index: Int = sender.layer.value(forKey: "selected_index") as! Int

        imageUrls.remove(at: index)

        collectionView.reloadData()
    }

    @IBAction private func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1ThirdTableTableViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1ThirdTableTableViewController") as? MakeTab1ThirdTableTableViewController else {
            return
        }

        CommonDataManager.share.itemForPost?.itemTitle = titleTextField.text
        CommonDataManager.share.itemForPost?.tabOne = TabOne()
        CommonDataManager.share.itemForPost?.tabOne?.contents = contentTextView.text

        for imageURL in imageUrls {
            if let data = try? Data(contentsOf: imageURL),
                let image = UIImage(data: data) {
                uploadImageFile(image) { urlString, _ in
                    DispatchQueue.main.async {
                        if CommonDataManager.share.imageURLs == nil {
                            CommonDataManager.share.imageURLs = []
                        }
                        CommonDataManager.share.imageURLs?.append(urlString)
                    }
                }
            }
        }
        navigationController?.pushViewController(makeTab1ThirdTableTableViewController, animated: true)
    }

    func buildBody(_ fileURL: URL) -> Data? {
        guard let filedata = try? Data(contentsOf: fileURL) else {
            return nil
        }

        //--header 'Content-Type: multipart/form-data' --header 'Accept: application/json' -F file=    Array[file]
        let boundary = "header"
        let headerLines = ["--\(boundary)",
            "Content-Type: multipart/form-data; Accept: application/json",
            "\r\n"]
        var data = headerLines.joined(separator: "\r\n").data(using: .utf8)
        if let file = "files=".data(using: .utf8) {
            data?.append(contentsOf: file)
        }
        data?.append(contentsOf: filedata)
        if let appendData = "\r\n--\(boundary)".data(using: .utf8) {
            data?.append(contentsOf: appendData)
            return data
        }
        return nil
    }

    func uploadImageFile(_ image: UIImage, completionHandler: @escaping((String, URLResponse?) -> Void) = { _, _ in }) {
        guard let url = URL(string: "http://ec2-13-125-62-50.ap-northeast-2.compute.amazonaws.com/item/uploadFile"),
            let imageData = UIImageJPEGRepresentation(image, 0.7) else {
                return
        }

        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(boundary: boundary,
                                      data: imageData,
                                      mimeType: "image/jpg")
        let task = URLSession.shared.dataTask(with: request) { data, res, _ in
            do {
                if let data = data, let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {

                    if let imageUrl = result["returnJson"] as? [String],
                        !imageUrl.isEmpty,
                        let urlString = imageUrl.first {
                        print(imageUrl)
                        completionHandler(urlString, res)
                    }
                    print(result)

                } else {
                    print("error!!!!!!!!!")
                }
            } catch {
                print("error!!!!")
            }
        }
        task.resume()
    }

    func createBody(boundary: String,
                    data: Data,
                    mimeType: String) -> Data {

        let body = NSMutableData()

        let boundaryPrefix = "--\(boundary)\r\n"

        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"files\"; filename=\"name.jpeg\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))

        return body as Data
    }
}

extension MakeTab1SecondViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        return true
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

        let imageUrl: URL = imageUrls[indexPath.item]

        cell.imageClearButton.layer.setValue(indexPath.row, forKey: "selected_index")
        cell.imageClearButton.addTarget(self, action: #selector(tappedClearImage), for: .touchUpInside)

        DispatchQueue.global().async {
            guard
                let imageData: Data = try? Data(contentsOf: imageUrl as URL),
                let image: UIImage = UIImage(data: imageData) else {

                return
            }

            DispatchQueue.main.async {
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

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let imageUrl = info[UIImagePickerControllerImageURL] else {
            return
        }

        guard let url = imageUrl as? URL else {
            return
        }

        imageUrls.append(url)

        collectionView.reloadData()

        dismiss(animated: true, completion: nil)
    }

//    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
//        // handle denied albums permissions case
//    }
//
//    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
//        // handle denied camera permissions case
//    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            append(data)
        }
    }
}
