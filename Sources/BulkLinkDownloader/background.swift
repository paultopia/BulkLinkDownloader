import Cocoa

public class BackgroundDownloader: NSObject, URLSessionDelegate, URLSessionDownloadDelegate{

    private var downloadQueue: [URLSessionDownloadTask] = []
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "MySession")
        config.isDiscretionary = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    func addDownloadToQueue(address: String){
        let url = URL(string: address)!
        let backgroundTask = urlSession.downloadTask(with: url)
        downloadQueue.append(backgroundTask)
    }

    func runAllDownloads(){
        downloadQueue.forEach {$0.resume()}
    }

    public func urlSession(_ u: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo: URL) {
        print("called completion handler")
        print(didFinishDownloadingTo)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("background download threw an error")
        print(error)
    }

}
