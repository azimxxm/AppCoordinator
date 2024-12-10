// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

public final class AppCoordinator {
    private let navigationController: UINavigationController
    
    public init() {
        self.navigationController = UINavigationController()
        self.navigationController.modalPresentationStyle = .fullScreen
    }
    
    /// Set the root SwiftUI view for the navigation controller.
    public func setRootView(_ view: some View, setNavBarHidden: Bool = false) -> AnyView {
        setRoot(view)
        self.navigationController.setNavigationBarHidden(setNavBarHidden, animated: false)
        return AnyView(ViewControllerWrapper(navigationController))
    }
    
    private func setRoot(_ view: some View) {
        let hostingController = UIHostingController(rootView: view)
        navigationController.setViewControllers([hostingController], animated: false)
    }
    
    /// Push a new UIViewController onto the navigation stack.
    public func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.pushViewController(viewController, animated: animated)
        completion?()
    }
    
    /// Pop the current UIViewController from the navigation stack.
    public func pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.popViewController(animated: animated)
        completion?()
    }
    
    /// Present a UIViewController modally.
    public func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    /// Dismiss the current modal UIViewController.
    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    // Pop To Root ViewController
    public func backToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    // return to specific view controller
    public func backToSpecificViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.popToViewController(viewController, animated: animated)
    }
}


extension View {
    public func wrapInToViewController()-> UIViewController {
        return UIHostingController(rootView: self)
    }
}


public struct ViewControllerWrapper: UIViewControllerRepresentable {
    private let viewController: UIViewController
    
    public init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func makeUIViewController(context: Context) -> UIViewController {
        return self.viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
