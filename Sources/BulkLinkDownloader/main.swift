import Cocoa
import SwiftSoup

let bg = BackgroundDownloader()

let url = URL(string: "http://paultopia.org/downloadtest.html")!

func listLinks(_ html: String) -> [String] {
    let doc = try! SwiftSoup.parse(html)
    let links = try! doc.select("a")
    let out = links.array().map {try! $0.attr("href")}
    return out
}

func printLinks(_ s: String){
    let links = listLinks(s)
    var link: String
    for l in links {
        link = "http://paultopia.org/" + l
        print(link)
        bg.addDownloadToQueue(address: link)
    }
    bg.runAllDownloads()
}

let data = try! String(contentsOf: url)
printLinks(data)
