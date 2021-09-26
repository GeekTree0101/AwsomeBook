

import Foundation
import NeedleFoundation
import SwiftUI

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->SearchComponent->BookDetailComponent") { component in
        return BookDetailDependency3c2e57b0b804d0aea81eProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->SearchComponent") { component in
        return SearchDependencyf947dc409bd44ace18e0Provider(component: component)
    }
    
}

// MARK: - Providers

private class BookDetailDependency3c2e57b0b804d0aea81eBaseProvider: BookDetailDependency {
    var bookRepository: BookRepository {
        return rootComponent.bookRepository
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->SearchComponent->BookDetailComponent
private class BookDetailDependency3c2e57b0b804d0aea81eProvider: BookDetailDependency3c2e57b0b804d0aea81eBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent.parent as! RootComponent)
    }
}
private class SearchDependencyf947dc409bd44ace18e0BaseProvider: SearchDependency {
    var bookSearchService: BookSearchService {
        return rootComponent.bookSearchService
    }
    var bookRepository: BookRepository {
        return rootComponent.bookRepository
    }
    var router: RouterLogic {
        return rootComponent.router
    }
    private let rootComponent: RootComponent
    init(rootComponent: RootComponent) {
        self.rootComponent = rootComponent
    }
}
/// ^->RootComponent->SearchComponent
private class SearchDependencyf947dc409bd44ace18e0Provider: SearchDependencyf947dc409bd44ace18e0BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(rootComponent: component.parent as! RootComponent)
    }
}
