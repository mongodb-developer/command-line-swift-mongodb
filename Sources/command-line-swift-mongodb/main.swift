      import Foundation
      import MongoSwiftSync

      var murl: String = "mongodb+srv://<username>:\(ProcessInfo.processInfo.environment["PASS"]!)@myfirstcluster.zbcul.mongodb.net/<dbname>?retryWrites=true&w=majority"
      let client = try MongoClient(murl)

      let db = client.db("students")
      let session = client.startSession(options: ClientSessionOptions(causalConsistency: true))

      struct Person: Codable {
         let firstname: String
         let lastname: String
         let date: Date = Date()
         let assigned: Bool
         let _id: BSONObjectID
      }

      let path = "/Users/mlynn/Desktop/example.csv"
      var tempAssigned: Bool
      var count: Int = 0
      var header: Bool = true

      let personCollection = db.collection("people", withType: Person.self)

      do {
         let contents = try String(contentsOfFile: path, encoding: .utf8)
         let rows = contents.components(separatedBy: NSCharacterSet.newlines)
         for row in rows {
            if row != "" {
                  var values: [String] = []
                  values = row.components(separatedBy: ",")
                  if header == true {
                     header = false
                  } else {
                     if String(values[2]).lowercased() == "false" || Bool(values[2]) == false {
                        tempAssigned = false
                     } else {
                        tempAssigned = true
                     }
                     try personCollection.insertOne(Person(firstname: values[0], lastname: values[1], assigned: tempAssigned, _id: BSONObjectID()), session: session)
                     count.self += 1
                     print("Inserted: \(count) \(row)")
                     
                  }
            }
         }
      }
