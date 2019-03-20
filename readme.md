
Currently: learning project. 

Eventually: maybe an actual useful CLI to bulk download, e.g., page with links to a bunch of pdfs.

background downloader will not actually do anything until the next execution of the code.  when I write a commandline interface, I should give it a status option to pass to poke into the background downloader and see how it's doing.  parallel downloader (which may really be concurrent, but close enough) works and will actually produce output on current run of program.

check out [this old SO](https://stackoverflow.com/questions/43299838/nsurlsession-background-configuration-benefits-on-macos) to explain what's happening with background download.

but background downloader also doesn't seem to work well on anything that takes more than an instant or two.  Possibly beause it gets overridden on next run or something?  Not sure.  Requires further investigation, but, as of now, background downloader doesn't work.
