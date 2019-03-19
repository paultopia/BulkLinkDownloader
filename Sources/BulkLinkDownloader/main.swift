import Cocoa
import SwiftSoup

let runLoop = CFRunLoopGetCurrent()
let bg = BackgroundDownloader()

print("hello world")

let url = URL(string: "http://paultopia.org/downloadtest.html")!

func listLinks(_ html: String) -> [String] {
    let doc = try! SwiftSoup.parse(html)
    let links = try! doc.select("a")
    let out = links.array().map {try! $0.attr("href")}
    return out
}

func myPrint(_ s: String){
    print(s)
}

func printLinks(_ s: String){
    let links = listLinks(s)
    for link in links {
        print(link)
        bg.addDownloadToQueue(address: link)
    }
    bg.runAllDownloads()
}

let outputTask = printLinks

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
