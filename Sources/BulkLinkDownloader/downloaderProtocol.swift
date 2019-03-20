import Cocoa

protocol Downloader: URLSessionDownloadDelegate {
    var downloadQueue: [URLSessionDownloadTask] { get set }
    func addDownloadToQueue(address: String)
    func runAllDownloads()
}
