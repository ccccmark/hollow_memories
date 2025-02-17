<#
Applys post processing to livestream recordings.

usage:
postporcess.ps1 <stream_url>

Run this script while the stream is live.
Press enter after the stream is saved.
#>
$stream_url = $args[0]
$filename = yt-dlp --write-description --skip-download -o "[%(uploader)s][%(upload_date)s] %(title)s (%(id)s)" --get-filename $stream_url
yt-dlp --write-thumbnail --write-description --skip-download -o stream $stream_url
Read-Host -Prompt 'Press [Enter] to continue. Make sure ytarchive has finished recording the stream.'
$description = [IO.File]::ReadAllText(".\stream.description")
ffmpeg -i .\stream.mp4 -i .\stream.jpg -map 1 -map 0 -c copy -disposition:0 attached_pic -metadata comment=$description $($filename + ".mp4")