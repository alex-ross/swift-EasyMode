public extension Array {
    func grouped(byNumberOfElements numberOfElements: Int) -> [[Element]] {
        var newArray = [[Element]]()
        var start = 0
        let end: () -> Int = { [start + numberOfElements, self.endIndex].min()! }

        while self[start ..< end()].count > 0 {
            let slice = self[start ..< end()].map { $0 }
            newArray.append(slice)

            start = [end(), endIndex].min()!
        }

        return newArray
    }
}
