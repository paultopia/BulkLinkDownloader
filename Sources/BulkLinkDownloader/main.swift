import Cocoa

let runLoop = CFRunLoopGetCurrent()

print("hello world")

let url = URL(string: "http://paultopia.org")!

// func listLinks(url: URL) -> [URL]? {
    
// }

func myPrint(_ s: String){
    print(s)
}

let outputTask = myPrint

func operateOnPage(url: URL) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("TRANSPORT ERRORED")
            print(error)
            return
        }
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("SERVER ERRORED")
            return
        }
        if let mimeType = httpResponse.mimeType, mimeType == "text/html",
           let data = data,
           let string = String(data: data, encoding: .utf8) {
            outputTask(string)
        }
        print("stopping loop")
        CFRunLoopStop(runLoop)
    }
    task.resume()
}

operateOnPage(url: url)

CFRunLoopRun()
// RunLoop.main.run()
