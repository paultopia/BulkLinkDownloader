import Cocoa
import SwiftSoup

let bg = BackgroundDownloader()

let url = URL(string: "http://paultopia.org/downloadtest.html")!

func exten(ofLink link: String, isIn extensList: [String]) -> Bool {
    if let xtn = URL(string: link)?.pathExtension {
        return extensList.contains(xtn)
    }
    return false
}

func listLinks(_ html: String) -> [String] {
    let doc = try! SwiftSoup.parse(html)
    // note to self: need to use baseUri argument with original url to get relative links sorted.
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
