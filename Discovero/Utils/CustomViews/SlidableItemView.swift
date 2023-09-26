import UIKit

class SlidableItemView: UIView {
    
    var initialPosition: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Color.appWhite
        layer.cornerRadius = frame.size.width/2
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: superview)
        
        switch gesture.state {
        case .began:
            initialPosition = center
        case .changed:
            let newX = initialPosition.x + translation.x
            center = CGPoint(x: newX, y: initialPosition.y)
            
        case .ended:
            let newX = initialPosition.x + translation.x
            center = CGPoint(x: newX, y: initialPosition.y)
        default:
            break
        }
    }
}
