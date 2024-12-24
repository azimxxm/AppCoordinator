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
    
    /// Push a SwiftUI view onto the navigation stack.
    public func pushSwiftUIView(_ view: some View, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.pushViewController(view.wrapInToViewController(), animated: animated)
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
    
    /// Present a SwiftUI view modally.
    public func presentSwiftUIView(_ view: some View, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(view.wrapInToViewController(), animated: animated, completion: completion)
    }
    
    /// Dismiss the current modal UIViewController.
    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
    /// Pop to the root view controller.
    public func backToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    /// Pop to a specific view controller.
    public func backToSpecificViewController(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.popToViewController(viewController, animated: animated)
    }
    
    /// Show a view controller using default presentation style.
    public func show(vc: UIViewController) {
        navigationController.show(vc, sender: nil)
    }
    
    /// Replace the navigation stack with a new set of view controllers.
    public func replaceStack(with viewControllers: [UIViewController], animated: Bool = true) {
        navigationController.setViewControllers(viewControllers, animated: animated)
    }
    
    /// Check if a view controller exists in the navigation stack.
    public func containsViewController(ofType type: UIViewController.Type) -> Bool {
        return navigationController.viewControllers.contains(where: { $0.isKind(of: type) })
    }
    
    /// Push a view conditionally, if not already in the stack.
    public func pushIfNotPresent(_ viewController: UIViewController, animated: Bool = true) {
        guard !containsViewController(ofType: type(of: viewController)) else { return }
        push(viewController, animated: animated)
    }
    
    /// Get the current top view controller.
    public var topViewController: UIViewController? {
        return navigationController.topViewController
    }
    
    /// Set a custom transition animation for the navigation controller.
    public func setCustomTransition(_ animation: CATransition) {
        navigationController.view.layer.add(animation, forKey: kCATransition)
    }
}

// MARK: - Extensions for SwiftUI Integration
extension View {
    /// Wrap a SwiftUI view into a `UIViewController`.
    public func wrapInToViewController() -> UIViewController {
        return UIHostingController(rootView: self)
    }
    
    /// Wrap a SwiftUI view into a `UINavigationController`.
    public func wrapInToNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: UIHostingController(rootView: self))
    }
}

// MARK: - `ViewControllerWrapper`
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

