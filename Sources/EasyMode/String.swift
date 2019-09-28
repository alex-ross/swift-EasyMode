import Foundation

// MARK: - Search helpers

extension String {
    /// Check if string is a fuzzy match with another string
    /// - Parameter search: The search string
    public func isFuzzyMatched(using search: String) -> Bool {
        var search = search.platformIndependentLowercase().replacingOccurrences(of: " ", with: "")

        for char in self.platformIndependentLowercase() {
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
            return self.lowercased()
        }
    }
    #endif

    #if os(iOS)
    fileprivate func platformIndependentLowercase() -> String {
        if #available(iOS 9.0, *) {
            return self.localizedLowercase
        } else {
            return self.lowercased()
        }
    }
    #endif

    #if os(watchOS)
    fileprivate func platformIndependentLowercase() -> String {
        if #available(watchOS 2.0, *) {
            return self.localizedLowercase
        } else {
            return self.lowercased()
        }
    }
    #endif

    #if os(tvOS)
    fileprivate func platformIndependentLowercase() -> String {
        if #available(tvOS 9.0, *) {
            return self.localizedLowercase
        } else {
            return self.lowercased()
        }
    }
    #endif

    #if !os(macOS) && !os(iOS) && !os(watchOS) && !os(tvOS)
    fileprivate func platformIndependentLowercase() -> String {
        return self.lowercased()
    }
    #endif
}
