import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create the main window.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create and set the root view controller.
        let gameViewController = GameViewController()
        window?.rootViewController = gameViewController
        
        // Make the window visible.
        window?.makeKeyAndVisible()
        
        return true
    }
}
