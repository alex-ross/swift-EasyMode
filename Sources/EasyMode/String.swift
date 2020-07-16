import Foundation

// MARK: - Search helpers

extension String {
    /// Returns the receiver if it's present otherwise returns nil
    public var presence: String? {
        isPresent ? self : nil
    }

    /// A string is blank if it's empty or contains whitespaces only
    public var isBlank: Bool {
        removingCharacters(from: .whitespacesAndNewlines) == ""
    }

    /// A string is present if it's not blank.
    public var isPresent: Bool {
        !isBlank
    }

    /// Removes characters in character set
    public func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }

    /// Check if string is a fuzzy match with another string
    /// - Parameter search: The search string
    public func isFuzzyMatched(using search: String) -> Bool {
        var search = search.platformIndependentLowercase().removingCharacters(from: .whitespacesAndNewlines)

        for char in platformIndependentLowercase() {
            if char == search.first {
                search.removeFirst()
            }
        }

        return search.isEmpty
    }

    #if os(macOS)
        fileprivate func platformIndependentLowercase() -> String {
            if #available(macOS 10.11, *) {
                return self.localizedLowercase
            } else {
                return lowercased()
            }
        }
    #endif

    #if os(iOS)
        fileprivate func platformIndependentLowercase() -> String {
            if #available(iOS 9.0, *) {
                return self.localizedLowercase
            } else {
                return lowercased()
            }
        }
    #endif

    #if os(watchOS)
        fileprivate func platformIndependentLowercase() -> String {
            if #available(watchOS 2.0, *) {
                return self.localizedLowercase
            } else {
                return lowercased()
            }
        }
    #endif

    #if os(tvOS)
        fileprivate func platformIndependentLowercase() -> String {
            if #available(tvOS 9.0, *) {
                return self.localizedLowercase
            } else {
                return lowercased()
            }
        }
    #endif

    #if !os(macOS) && !os(iOS) && !os(watchOS) && !os(tvOS)
        fileprivate func platformIndependentLowercase() -> String {
            return lowercased()
        }
    #endif
}
