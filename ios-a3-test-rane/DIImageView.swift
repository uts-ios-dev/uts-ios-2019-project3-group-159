//
//  DIImageView.swift
//  ios-a3-test-rane
//
//  Created by Lahiru Ranasinghe on 30/5/19.
//  Copyright © 2019 Lahiru Ranasinghe. All rights reserved.
//

import Foundation

import UIKit

open class DIImageView: UIImageView, UITextFieldDelegate {
    
    // MARK: - Lifecycle
    
    public override init(image: UIImage?) {
        super.init(image: image)
        configure()
    }
    
    public override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        configure()
    }
    
    override init(frame: CGRect) {
        print("methana")
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        
        addSubview(saveButton)
        addSubview(addTextButton)
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(panRecognizer)
        isUserInteractionEnabled = true
    }
    
    // MARK: - Subviews
    
    private lazy var caption: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
//        textField.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        textField.placeholder = "Enter text here..."
        textField.textAlignment = .center
        textField.textColor = .white
        textField.tintColor = .white
        textField.keyboardAppearance = .dark
        textField.delegate = self
        return textField
    }()
    
    var saveButton: UIButton = {
        let saveBtn = UIButton()
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.frame = CGRect(x: 200 , y: 550, width: 300, height: 500)
        saveBtn.addTarget(self, action: #selector(DIImageView.pressedSaveBtn(button:)), for: .touchUpInside)
        return saveBtn
    }()
    
    var addTextButton: UIButton = {
        let addTextBtn = UIButton()
        addTextBtn.setTitle("Add Text", for: .normal)
        addTextBtn.frame = CGRect(x: -100 , y: 550, width: 300, height: 500)
        addTextBtn.addTarget(self, action: #selector(DIImageView.addTextTrigger(button:)), for: .touchUpInside)
        return addTextBtn
    }()
    
    private var captionCenterY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var captionCenterX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let captionSize = CGSize(width: bounds.size.width, height: 32)
        caption.bounds = CGRect(origin: CGPoint.zero, size: captionSize)
        
//        captionCenterX = bounds.width/2
        caption.center = CGPoint(x: captionCenterX, y: captionCenterY)
    }
    
    // MARK: - Gestures
    
    private lazy var tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
    private lazy var panRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(_:)))
    
    @objc private func tapped(_ sender: AnyObject) {
        if caption.isFirstResponder {
            print("here")
            caption.resignFirstResponder()
            caption.isHidden = caption.text?.isEmpty ?? true
        } else {
            print("here2")
            caption.becomeFirstResponder()
            caption.isHidden = false
        }
    }
    
    @objc private func panned(_ sender: AnyObject) {
        guard let panRecognizer = sender as? UIPanGestureRecognizer else { return }
        let location = panRecognizer.location(in: self)
        captionCenterY = location.y
        captionCenterX = location.x
    }
    
    // MARK: - Text Field Delegate
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let captionFont = textField.font, textField == caption && !string.isEmpty else { return true }
        let textSize = textField.text?.size(withAttributes: [NSAttributedString.Key.font: captionFont]) ?? CGSize.zero
        return (textSize.width + 16 < textField.bounds.size.width)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard caption == textField else { return }
        caption.isHidden = caption.text?.isEmpty ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard caption == textField else { return true }
        return caption.resignFirstResponder()
    }
    
    
//    func getImage(imageView: UIImageView, textField: UITextField) -> UIImage{
//
//        //Get the new image after snapshot method
//        let cropImage = imageView.snapshotView(afterScreenUpdates: true)
//
//        //Create new imageView with the cropImage
//        let newImageView = UIImageView(frame: self)
//
//        //Origin point of the Snapshot Frame.
//        let frameOriginX = frame.origin.x
//        let frameOriginY = frame.origin.y
//
//        UIGraphicsBeginImageContextWithOptions(newImageView.frame.size, false, cropImage.scale)
//        let context = UIGraphicsGetCurrentContext()!
//
//        //Render the "cropImage" in the CGContext
//        newImageView.layer.render(in: context)
//
//        //Position of the TextField
//        let tf_X = textField.frame.origin.x - frameOriginX
//        let tf_Y = textField.frame.origin.y - frameOriginY
//
//        //Context Translate with TextField position
//        context.translateBy(x: tf_X, y: tf_Y)
//
//        //Render the "TextField" in the CGContext
//        textField.layer.render(in: context)
//
//        //Create newImage
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        return newImage
//    }
    
    @objc func pressedSaveBtn(button: UIButton){
        print("save")
//        var image = getImage(imageView: self,textField: caption)
//        UIGraphicsBeginImageContextWithOptions(self.frame.bounds.size, self.view.isOpaque, 0.0)
//        defer { UIGraphicsEndImageContext() }
//        if let context = UIGraphicsGetCurrentContext() {
//            self.view.layer.render(in: context)
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//           // return image
//        }
//        //return nil
//
//        print(image)
    }
    
    @objc func addTextTrigger(button: UIButton){
        addSubview(caption)
        
        captionCenterY = bounds.height/2
        captionCenterX = bounds.width/2
        caption.becomeFirstResponder()
        caption.isHidden = false
    }
}
