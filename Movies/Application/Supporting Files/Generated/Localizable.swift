// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum App {
    /// Movies
    internal static let title = L10n.tr("Localizable", "app.title")
  }

  internal enum EmptyText {
    /// No content
    internal static let `default` = L10n.tr("Localizable", "emptyText.default")
    /// Has not favorite movies
    internal static let notFavorite = L10n.tr("Localizable", "emptyText.notFavorite")
    /// Movies not found
    internal static let notFound = L10n.tr("Localizable", "emptyText.notFound")
    /// Search Movies
    internal static let search = L10n.tr("Localizable", "emptyText.search")
  }

  internal enum Favorite {
    /// Favorites
    internal static let title = L10n.tr("Localizable", "favorite.title")
  }

  internal enum SearchBar {
    /// Search
    internal static let placeholder = L10n.tr("Localizable", "searchBar.placeholder")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
