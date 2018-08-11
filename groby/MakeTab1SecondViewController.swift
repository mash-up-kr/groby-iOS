//
//  MakeTap1SecondViewController.swift
//  groby
//
//  Created by 이재성 on 12/08/2018.
//  Copyright © 2018 mashup. All rights reserved.
//

import UIKit
import RichEditorView
import TLPhotoPicker

class MakeTab1SecondViewController: UIViewController {
    @IBOutlet weak var editor: RichEditorView!
    lazy var toolbar: RichEditorToolbar = {
        let toolbar = RichEditorToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        toolbar.options = [RichEditorDefaultOption.image]
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editor.placeholder = "내용"
        toolbar.editor = editor
        editor.inputAccessoryView = toolbar
        toolbar.delegate = self
        
        navigationItem.setCustomTitle("내용 작성")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        guard let makeTab1ThirdTableTableViewController = storyboard?.instantiateViewController(withIdentifier: "MakeTab1ThirdTableTableViewController") as? MakeTab1ThirdTableTableViewController else { return }
        navigationController?.pushViewController(makeTab1ThirdTableTableViewController, animated: true)
    }
}

extension MakeTab1SecondViewController: RichEditorToolbarDelegate {
    func richEditorToolbarInsertImage(_ toolbar: RichEditorToolbar) {
        let photoPickerViewController = TLPhotosPickerViewController()
        photoPickerViewController.delegate = self
        present(photoPickerViewController, animated: true, completion: nil)
    }
}

extension MakeTab1SecondViewController: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        withTLPHAssets.forEach {
            $0.phAsset?.getURL(completionHandler: { [weak self] url in
                guard let urlString = url?.absoluteString else { return }
                self?.toolbar.editor?.insertImage(urlString, alt: "")
            })
        }
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        // handle denied albums permissions case
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        // handle denied camera permissions case
    }
}
