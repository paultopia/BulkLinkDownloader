import Cocoa

public class ParallelDownloader: NSObject {
    internal var downloadQueue: [URLSessionDownloadTask] = []
    private var fm = FileManager()
    private lazy var urlSession = URLSession(configuration: .default,
                                             delegate: self,
                                             delegateQueue: nil)
    let runLoop = CFRunLoopGetCurrent()
    internal var remainingToDownload = 0
}

extension ParallelDownloader: URLSessionDelegate, URLSessionDownloadDelegate {
    public func urlSession(_ u: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo: URL) {
        print("called completion handler")
        let s = try! String(contentsOf: didFinishDownloadingTo)
        print(s)
        remainingToDownload -= 1
        if remainingToDownload < 1 {
            CFRunLoopStop(runLoop)
        }
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let e = error {
            print("parallel download threw an error")
            print(e)
        }
    }
}

extension ParallelDownloader: Downloader {

    func addDownloadToQueue(address: String){
        let url = URL(string: address)!
        let parallelTask = urlSession.downloadTask(with: url)
        downloadQueue.append(parallelTask)
        remainingToDownload += 1
    }

    func runAllDownloads(){
        downloadQueue.forEach {$0.resume()}
        CFRunLoopRun()
    }
}
