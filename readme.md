
Currently: learning project. 

Eventually: maybe an actual useful CLI to bulk download, e.g., page with links to a bunch of pdfs.


Strange behavior at the previous commit.  Logging it here.

oh wow. I've discovered some really weird behavior. Sometimes, I'll change this code, and then I'll get outputs from the previous version when I run it. Then I run it again and get the correct current output.

like, I added functionality to filter the links downloaded by extension. The first time I ran it with extensions limited to "txt", it produced output as if it downloaded the "txt" and the "md" files. The second time, no changes to the code at all, it just produced the txt files.

like, wtf? this has GOT to be the background code messing with me somehow...

suppose I should really start looking at server logs and see when downloads are actually happening. but first I think I'll put a slow-downloading file up there to see what happens when I download that.

my hypothesis is that the background download isn't actually re-waking the application and so sometimes it just doesn't process the temp files it downloads until I run it again. which would be weird but not totally implausible...

and would mean I would need to put the async code I removed back in. maybe.

[commit that removed the async code](https://github.com/paultopia/BulkLinkDownloader/commit/9f3c18ca599b8065ef0f928d80d4b6e9d04fe63e)

oh yeah.  check out [this old SO](https://stackoverflow.com/questions/43299838/nsurlsession-background-configuration-benefits-on-macos) that's totally what's happening.  Do I need to do this background, or can I just change it to a different kind of async that keeps the app open?
