import Cocoa
import SwiftSoup

let bg = BackgroundDownloader()

let address = "http://paultopia.org/downloadtest.html"

func exten(ofLink link: String, isIn extensList: [String]) -> Bool {
    if let xtn = URL(string: link)?.pathExtension {
        return extensList.contains(xtn)
    }
    return false
}

func listLinks(_ html: String, origin: String) -> [String] {
    let doc = try! SwiftSoup.parse(html, origin)
    let links = try! doc.select("a")
    let out = links.array().map {try! $0.absUrl("href")}
    return out
}

func haveExten(types: [String]?, links: [String]) -> [String] {
    if let extens = types {
        return links.filter {exten(ofLink: $0, isIn: extens)}
    }
    return links
}

func printLinks(_ s: String, origin: String, types: [String]?){
    let links = haveExten(types: types, links: listLinks(s, origin: origin))
    for l in links {
        print(l)
        bg.addDownloadToQueue(address: l)
    }
    bg.runAllDownloads()
}

func scrape_data(from address: String, only: [String]?){
    let url = URL(string: address)!
    let data = try! String(contentsOf: url)
    printLinks(data, origin: address, types: only)
}


scrape_data(from: address, only: ["txt"])
