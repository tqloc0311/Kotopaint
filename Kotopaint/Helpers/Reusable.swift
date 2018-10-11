import UIKit

protocol ReusableView: class {
    static var identifier: String { get }
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}

extension UITableView {
    func register<T: UITableViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
        let identifier = T.identifier
        let nibName = T.nibName
        
        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    // DequeueReusableCell with identifier
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T where T: ReusableView {
        guard let cell =  self.dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
        let identifier = T.identifier
        let nibName = T.nibName
        
        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    // DequeueReusableCell with identifier
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell =  self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
