import UIKit

/**

Collection of static functions that help managing the scroll view content.

*/
struct AukScrollViewContent {
  
  /**

  :returns: Array of AukView objects that are subviews of the given scroll view.
  
  */
  static func aukViews(scrollView: UIScrollView) -> [AukView] {
    return scrollView.subviews.filter { $0 is AukView }.map { $0 as! AukView }
  }
  
  /**
  
  Positions the content views of the scroll view next to each other. The width of each subview equals the width of the scroll view.
  
  */
  static func layout(scrollView: UIScrollView, pageSize: CGSize, pageIndex: Int) {
    let subviews = aukViews(scrollView)

    for (index, subview) in enumerate(subviews) {
      subview.removeFromSuperview()
      scrollView.addSubview(subview)
      subview.setTranslatesAutoresizingMaskIntoConstraints(false)
      
      iiAutolayoutConstraints.equalSize(subview, viewTwo: scrollView, constraintContainer: scrollView)
      iiAutolayoutConstraints.fillParent(subview, parentView: scrollView, margin: 0, vertically: true)
      
      if index == 0 {
        iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Left, margin: 0)
      }
      
      if index == subviews.count - 1 {
        iiAutolayoutConstraints.alignSameAttributes(subview, toItem: scrollView,
          constraintContainer: scrollView, attribute: NSLayoutAttribute.Right, margin: 0)
      }
    }
    
    iiAutolayoutConstraints.viewsNextToEachOther(subviews, constraintContainer: scrollView,
      margin: 0, vertically: false)
    
//    updateContentSize(scrollView, pageSize: pageSize)
//    positionSubviews(scrollView, pageSize: pageSize)
//    updateContentOffset(scrollView, pageSize: pageSize, pageIndex: pageIndex)
  }
  
  /**
  
  Update content size of the scroll view so it can fit all the subviews.  The width of each subview equals the width of the scroll view.
  
  */
  static func updateContentSize(scrollView: UIScrollView, pageSize: CGSize) {
    let subviews = aukViews(scrollView)
    
    let contentWidth = CGFloat(subviews.count) * pageSize.width
    let contentHeight = pageSize.height
    
    scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
  }
  
  /**
  
  Positions all the AukView views inside the scroll view.
  
  */
  static func positionSubviews(scrollView: UIScrollView, pageSize: CGSize) {
    let subviews = aukViews(scrollView)
    
    var xOrigin: CGFloat = 0
    
    for subview in subviews {
      let origin = CGPoint(x: xOrigin, y: 0)
      positionSingleSubview(scrollView, subview: subview, origin: origin, pageSize: pageSize)
      xOrigin += pageSize.width
    }
  }
  
  /**
  
  Positions the single subview at the given origin. Sets the width of the subview to be equal to the width of the scroll view.
  
  */
  static func positionSingleSubview(scrollView: UIScrollView, subview: UIView,
    origin: CGPoint, pageSize: CGSize) {
      
    subview.frame.origin = origin
    subview.frame.size = pageSize
  }
  
  /// Updates the content offset based on the given size of the page and its index
  static func updateContentOffset(scrollView: UIScrollView, pageSize: CGSize, pageIndex: Int) {
    scrollView.contentOffset.x = CGFloat(pageIndex) * pageSize.width
  }
}