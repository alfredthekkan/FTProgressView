
import Foundation
import UIKit

class SanuView: UIView {
    
    var progress: CGFloat = 0.0
    var lineWidth: CGFloat = 10
    var ovalWidth: CGFloat = 10
    var ovalColor = UIColor.yellow
    var lineColor = UIColor.yellow
    var duration: CGFloat = 10.0
    
    private var _animation: CABasicAnimation!
    private var _lineShapeLayer: CAShapeLayer?
    private var _ellipseShapeLayer: CAShapeLayer?
    
    override func draw(_ rect: CGRect) {
        _ellipseShapeLayer?.removeFromSuperlayer()
        _lineShapeLayer?.removeFromSuperlayer()
        _setupEllipse(rect)
        _setupLine(rect)
        _setupAnimation()
    }
    
    func animate() {
        setNeedsDisplay()
    }
    
    private func _setupAnimation() {
        //Animation
        _animation = CABasicAnimation(keyPath: "strokeEnd")
        _animation.duration = CFTimeInterval(duration)
        _animation.fromValue = 0.0
        _animation.toValue = progress
        _animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        _ellipseShapeLayer?.add(_animation, forKey: "stroke")
    }
    
    override func layerWillDraw(_ layer: CALayer) {
        _ellipseShapeLayer?.removeFromSuperlayer()
        _lineShapeLayer?.removeFromSuperlayer()
    }
    
    private func _setupEllipse(_ rect: CGRect) {
        
        let ellipseShapeLayer = CAShapeLayer()
        ellipseShapeLayer.strokeColor = ovalColor.cgColor
        ellipseShapeLayer.lineWidth = ovalWidth
        ellipseShapeLayer.anchorPoint = CGPoint(x: rect.width/2, y: rect.height/2)
        ellipseShapeLayer.lineJoin = kCALineCapRound
        let ellipseRect = CGRect(origin: .zero, size: CGSize(width: rect.height, height: rect.width))
        
        let path = UIBezierPath(ovalIn: ellipseRect.insetBy(dx: 3 * ovalWidth, dy: 4 * lineWidth))
        ellipseShapeLayer.path = path.cgPath
        ellipseShapeLayer.lineCap = kCALineCapRound
        ellipseShapeLayer.strokeEnd = progress
        ellipseShapeLayer.fillColor = backgroundColor?.cgColor
        let transform = CGAffineTransform(rotationAngle: CGFloat( Double.pi/2))
        
        let transl = CGAffineTransform(translationX: 0, y: rect.height)
        ellipseShapeLayer.setAffineTransform(transform.concatenating(transl))
        
        ellipseShapeLayer.backgroundColor = backgroundColor?.cgColor
        _ellipseShapeLayer = ellipseShapeLayer
        layer.addSublayer(ellipseShapeLayer)
    }
    
    private func _setupLine(_ rect: CGRect) {
        let lineShapeLayer = CAShapeLayer()
        lineShapeLayer.lineWidth = lineWidth
        lineShapeLayer.strokeColor = lineColor.cgColor
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 4 * lineWidth, y: 0))
        linePath.addLine(to: CGPoint(x: rect.width - 4 * lineWidth , y: 0))
        lineShapeLayer.path = linePath.cgPath
        lineShapeLayer.lineCap = kCALineCapRound
        lineShapeLayer.strokeEnd = progress
        let translation = CGAffineTransform(translationX: 0, y: rect.height - lineWidth)
        lineShapeLayer.setAffineTransform(translation)
        layer.addSublayer(lineShapeLayer)
        _lineShapeLayer = lineShapeLayer
    }
    
}
