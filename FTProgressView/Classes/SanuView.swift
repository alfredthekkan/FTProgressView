
import Foundation
import UIKit

open class SanuView: UIView {
    
    /** Set the progress of the view */
    public var progress: CGFloat = 0.0
    
    /** set the line width */
    public var lineWidth: CGFloat = 10
    
    /** Set the line width for the oval */
    public var ovalWidth: CGFloat = 10
    
    /** Set the oval color */
    public var ovalColor = UIColor.yellow
    
    /** Set the line color */
    public var lineColor = UIColor.yellow
    
    /** Set the duration */
    public var duration: CGFloat = 1.0
    
    /** the animation object */
    private var _animation: CABasicAnimation!
    
    /** Line layer */
    private var _lineShapeLayer: CAShapeLayer?
    
    /** Ellipse layer */
    private var _ellipseShapeLayer: CAShapeLayer?
    
    /*!
     * @discussion Draw function
     * @param rect
     * @return Void
     */
    override open func draw(_ rect: CGRect) {
        
        //remove the existing layers
        _ellipseShapeLayer?.removeFromSuperlayer()
        _lineShapeLayer?.removeFromSuperlayer()
        
        //draw new layers
        _setupEllipse(rect)
        _setupLine(rect)
        
        //add animation
        _setupAnimation()
    }
    
    public func animate() {
        //calls drawrect(_:)
        setNeedsDisplay()
    }
    
    /*!
     * @discussion Creates the animation object and setup
     * @param nil
     * @return Void
     */
    private func _setupAnimation() {
        //Animation
        _animation = CABasicAnimation(keyPath: "strokeEnd")
        _animation.duration = CFTimeInterval(duration)
        _animation.fromValue = 0.0
        _animation.toValue = progress
        _animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        _ellipseShapeLayer?.add(_animation, forKey: "stroke")
    }
    
    /*!
     * @discussion Delegate called before the layer starts drawing
     * @param layer
     * @return Void
     */
    override open func layerWillDraw(_ layer: CALayer) {
        _ellipseShapeLayer?.removeFromSuperlayer()
        _lineShapeLayer?.removeFromSuperlayer()
    }
    
    /*!
     * @discussion Draws the ellipse layer
     * @param rect
     * @return Void
     */
    private func _setupEllipse(_ rect: CGRect) {
        
        //creates the layer
        let ellipseShapeLayer = CAShapeLayer()
        ellipseShapeLayer.strokeColor = ovalColor.cgColor
        ellipseShapeLayer.lineWidth = ovalWidth
        ellipseShapeLayer.anchorPoint = CGPoint(x: rect.width/2, y: rect.height/2)
        ellipseShapeLayer.lineJoin = kCALineCapRound
        let ellipseRect = CGRect(origin: .zero, size: CGSize(width: rect.height, height: rect.width))
        
        //creates the path
        let path = UIBezierPath(ovalIn: ellipseRect.insetBy(dx: 3 * ovalWidth, dy: 4 * lineWidth))
        ellipseShapeLayer.path = path.cgPath
        ellipseShapeLayer.lineCap = kCALineCapRound
        ellipseShapeLayer.strokeEnd = progress
        ellipseShapeLayer.fillColor = backgroundColor?.cgColor
        
        //creates the transform to show the ellipse properly in the UI
        let transform = CGAffineTransform(rotationAngle: CGFloat( Double.pi/2))
        let transl = CGAffineTransform(translationX: rect.width, y: 0)
        ellipseShapeLayer.setAffineTransform(transform.concatenating(transl))
        ellipseShapeLayer.backgroundColor = UIColor.red.cgColor
        _ellipseShapeLayer = ellipseShapeLayer
        
        //adds the ellipse layer to view's layer
        layer.addSublayer(ellipseShapeLayer)
    }
    
    /*!
     * @discussion Draw the line layer
     * @param rect
     * @return Void
     */
    private func _setupLine(_ rect: CGRect) {
        
        //creates the layer
        let lineShapeLayer = CAShapeLayer()
        lineShapeLayer.lineWidth = lineWidth
        lineShapeLayer.strokeColor = lineColor.cgColor
        
        //creates the path
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 4 * lineWidth, y: 0))
        linePath.addLine(to: CGPoint(x: rect.width - 4 * lineWidth , y: 0))
        lineShapeLayer.path = linePath.cgPath
        lineShapeLayer.lineCap = kCALineCapRound
        lineShapeLayer.strokeEnd = progress
        let translation = CGAffineTransform(translationX: 0, y: rect.height - lineWidth)
        lineShapeLayer.setAffineTransform(translation)
        
        //adds the ellipse layer to view's layer
        layer.addSublayer(lineShapeLayer)
        _lineShapeLayer = lineShapeLayer
    }
    
}
