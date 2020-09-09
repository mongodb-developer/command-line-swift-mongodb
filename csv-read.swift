import Foundation

let path = "/Users/mlynn/Desktop/example.csv" // change this to the path of your csv file
do {
   let contents = try String(contentsOfFile: path, encoding: .utf8)
   let rows = contents.components(separatedBy: NSCharacterSet.newlines)
   for row in rows {
      if row != "" {
            print("Got Row: \(row)")
      }
   }
}
