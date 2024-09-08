//
//  CustomTabbarController.swift
//  customTabbarNoSB
//
//  Created by Samet Korkmaz on 8.09.2024.
//

import UIKit
import Foundation

class CustomTabbarController: UITabBarController {

    let btnMiddle : UIButton = {
       let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.backgroundColor = UIColor(hex: "#fe989b", alpha: 1.0)
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        // UIImageView ekleyip, scaleAspectFill yapıyoruz
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill // Görselin dolmasını sağlıyoruz
        btn.clipsToBounds = true // Görselin dışarı taşmaması için
        btn.addTarget(self, action: #selector(aiButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .opaqueSeparator
        addSomeTabItems()
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 35, y: -34, width: 70, height: 70)
    }
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        setupCustomTabbar()
    }

   @objc func aiButtonTapped() {
        let geminiVC = GeminiViewController()
       geminiVC.modalPresentationStyle = .fullScreen
       present(geminiVC, animated: true, completion: nil)
    }
    func setupCustomTabbar(){
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .fill
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor(hex: "#fe989b", alpha: 1.0)
    }

    func addSomeTabItems() {
        let vc1 = UINavigationController(rootViewController: ViewC1())
        let vc2 = UINavigationController(rootViewController: ViewC2())
        let vc3 = UINavigationController(rootViewController: ViewC3())
        let vc4 = UINavigationController(rootViewController: ViewC4())
        let vc5 = UINavigationController(rootViewController: ViewC5())

        vc1.title = "Home"
        vc2.title = "Favorites"
        vc4.title = "Bookmark"
        vc5.title = "profile"
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        guard let items = tabBar.items else { return}
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "star.fill")
        items[2].image = UIImage()
        items[2].isEnabled = false // elamanı görünmez yaptık
        items[3].image = UIImage(systemName: "bookmark.fill")
        items[4].image = UIImage(systemName: "person.fill")
    }
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 20
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}

extension UIColor {
    public convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}

class ViewC1 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
class ViewC2 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
class ViewC3 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
class ViewC4 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
class ViewC5 : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

#Preview("UIKit"){
    CustomTabbarController()
}
