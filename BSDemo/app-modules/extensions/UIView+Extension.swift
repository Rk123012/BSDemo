//
//  UIView+Extension.swift
//  BSDemo
//
//  Created by Rezaul Karim on 23/10/24.
//

import Foundation

import UIKit

extension UIView {
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        if let selectedView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return selectedView
        } else {
            return UIView()
        }
    }
    
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
    
    public var topSafeAreaInset : CGFloat {
        var safeAreaInset: CGFloat = 0.0
        if #available(iOS 11.0, *), let window = UIApplication.shared.keyWindow {
            safeAreaInset = window.safeAreaInsets.top
        }
        return safeAreaInset
    }
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }

}




@IBDesignable extension UIView {
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
}
//extension UIView {
//    
//    func showDatePicker(contentType : DatePickerContent, currentDate : Date?, maximumDate : Date? = nil, minimumDate : Date? = nil, dateViewActionHandler : TVLDateInputHandler?){
//        if self.viewWithTag(TVLConstants.kDatePickerTag) == nil {
//            let dateView = TVLDatePickerView()
//            dateView.dateViewActionHandler = dateViewActionHandler
//            dateView.tag = TVLConstants.kDatePickerTag
//            dateView.datePickerContent = contentType
//            dateView.initialize(currentDate: currentDate, minimumDate: minimumDate, maximumDate: maximumDate)
//            dateView.frame = CGRect.init(x: 0.0, y: self.bounds.height, width: self.bounds.width, height: 240.0)
//            self.addSubview(dateView)
//            UIView.animate(withDuration: 0.5, animations: {
//                dateView.frame.origin.y = self.bounds.height - 240.0
//                self.layoutIfNeeded()
//            })
//        } else {
//            let dateView = self.viewWithTag(TVLConstants.kDatePickerTag) as? TVLDatePickerView
//            dateView?.datePickerContent = contentType
//            dateView?.updateCurrentDatePicker(currentDate: currentDate)
//        }
//    }
//    
//    func showInlineDatePicker(contentType : DatePickerContent, currentDate : Date?, dateViewActionHandler : TVLDateInputHandler?, minimumDate : Date? = nil, maximumDate : Date? = nil, tintColor : UIColor? =  UIColor(named: "GreenLevel1")){
//        if self.viewWithTag(TVLConstants.kDatePickerTag) == nil {
//            let dateView = TVLDatePickerView()
//            dateView.tintColor = tintColor
//            dateView.dateViewActionHandler = dateViewActionHandler
//            dateView.tag = TVLConstants.kDatePickerTag
//            dateView.datePickerContent = contentType
//            dateView.initialize(currentDate: currentDate, minimumDate: minimumDate, maximumDate: maximumDate, tintColor: tintColor)
//            if #available(iOS 14.0, *) {
//                dateView.datePicker.preferredDatePickerStyle = UIDatePickerStyle.inline
//                dateView.frame = CGRect.init(x: 0.0, y: self.bounds.height, width: self.bounds.width, height: 400.0)
//                self.addSubview(dateView)
//                UIView.animate(withDuration: 0.5, animations: {
//                    dateView.frame.origin.y = self.bounds.height - 400.0
//                    self.layoutIfNeeded()
//                })
//            } else {
//                // Fallback on earlier versions
//                dateView.frame = CGRect.init(x: 0.0, y: self.bounds.height, width: self.bounds.width, height: 240.0)
//                self.addSubview(dateView)
//                UIView.animate(withDuration: 0.5, animations: {
//                    dateView.frame.origin.y = self.bounds.height - 240.0
//                    self.layoutIfNeeded()
//                })
//
//            }
//           
//        } else {
//            let dateView = self.viewWithTag(TVLConstants.kDatePickerTag) as? TVLDatePickerView
//            dateView?.datePickerContent = contentType
//            dateView?.initialize(currentDate: currentDate, minimumDate: minimumDate, maximumDate: maximumDate)
//        }
//    }
//    
//    
//    func hideDatePicker(){
//        let dateView = self.viewWithTag(TVLConstants.kDatePickerTag)
//        UIView.animate(withDuration: 0.5) {
//            dateView?.frame.origin.y = self.bounds.height
//        } completion: { isCompleted in
//            dateView?.removeFromSuperview()
//        }
//
//    }
//}

extension UIView {
    
    func getBezierPath() -> UIBezierPath {
        
        let lineWidth:    CGFloat = 0
        let cornerRadius: CGFloat = self.cornerRadius
        let rect = self.frame.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        let path = UIBezierPath()
        
        // lower left corner
        path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius), controlPoint: CGPoint(x: rect.minX, y: rect.maxY))
        
        // left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        
        // upper left corner
        path.addQuadCurve(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY), controlPoint: CGPoint(x: rect.minX, y: rect.minY))
        
        // top
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        
        // upper right corner
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + cornerRadius), controlPoint: CGPoint(x: rect.maxX, y: rect.minY))
        
        // right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        
        // lower right corner
        path.addQuadCurve(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY), controlPoint: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // bottom (including callout)
        path.addLine(to: CGPoint(x: rect.midX , y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.close()
        
        return path
    }
    
    func getCircularBazierPath() -> UIBezierPath {
        let cornerRadius = CGSize(width: self.frame.width / 2, height: self.frame.height / 2)
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: cornerRadius)
        path.addClip()
        path.apply(CGAffineTransform(translationX: self.frame.minX, y: self.frame.minY))
        return path
    }

    func mask(withRect rect: CGRect, inverse: Bool = false) {
        let path = UIBezierPath(rect: rect)
        let maskLayer = CAShapeLayer()
       
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }

        maskLayer.path = path.cgPath

        self.layer.mask = maskLayer
    }

    func mask(withPath path: UIBezierPath, inverse: Bool = false) {
        let path = path
        let maskLayer = CAShapeLayer()
       
        if inverse {
            path.append(UIBezierPath(rect: self.bounds))
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func removeMaskLayer() {
        self.layer.mask = nil
    }
    
}
extension UIView{
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
    }
}

// MARK: - Extension for number scoll counter
extension UIView {
    
    var bottom: CGFloat {
        return frame.origin.y + frame.height
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    func animateIn() {
        
    }
    
}

extension Float {
    func round(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIView {
    func calculatePreferredHeight(preferredWidth: CGFloat) -> CGFloat {
        let widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: preferredWidth
        )
        addConstraint(widthConstraint)
        let height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        removeConstraint(widthConstraint)
        return height
    }
    
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}

extension UIView {

    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        guard subview.isDescendant(of: self) else {
            return nil
        }
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        return superview!.convert(frame, to: self)
    }
    
    func containerFrameBasedOnWindow(forTag tagIndex : Int) -> CGRect? {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return nil }
        guard let selectedView = self.viewWithTag(tagIndex) else { return nil }
        return selectedView.superview?.convert(selectedView.frame, to: window)
    }
    
}

extension UIView {

    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.locations = [0, 1]
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: -1.22, c: 1.22, d: 0, tx: -0.08, ty: 1))
        gradientLayer.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        gradientLayer.position = self.center
       layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func addEqualConstraintInto(view: UIView) {
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
}
