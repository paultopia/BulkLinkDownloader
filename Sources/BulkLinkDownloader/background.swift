import Cocoa

public class BackgroundDownloader: NSObject, URLSessionDelegate, URLSessionDownloadDelegate{

    private var downloadQueue: [URLSessionDownloadTask] = []
    private var fm = FileManager()
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
        let s = try! String(contentsOf: didFinishDownloadingTo)
        print(s)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let e = error {
            print("background download threw an error")
            print(e)
        }
    }

}
