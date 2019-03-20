import Cocoa

protocol Downloader: URLSessionDownloadDelegate {
    func addDownloadToQueue(address: String)
    func runAllDownloads()
}
