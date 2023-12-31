## What is ytdlp-batchaudio
ytdlp-batchaudio - or BA in short - is a simple batch script to use [yt-dlp](https://github.com/yt-dlp/yt-dlp) to download songs from streaming platforms. 


## Requirements
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) is installed.
- [ffmpeg](https://www.gyan.dev/ffmpeg/builds/) is installed.


## Usage & Behaviour
- Make sure the global path to the base directory for the downloaded songs is correctly set inside the batch file. (As described inside the script)
- Place the batch script in the same folder containing the yt-dlp executable.
- Run the script.
- Enter the URL to the Video/Playlist (no spaces before and after!) and follow the instructions.


### In case of a playlist: 
- The script will always create a folder called `playlist_X` where `X` is a number starting from 0.
- If a folder with such a name already exists and it's not empty, a new folder will be created with an incremented number.
- The downloaded files will be likely be in `.webm` format.
- But for the sake of compability BA will always extract the audio into an `.ogg` file and delete the `.webm` files.


### In case of a specific format:
- Since BA is primarily made to download audio, other functionalities of yt-dlp are not supported.
- However the script will at least offer the option of downloading a specific format of the Video.
- All files will be saved inside the base directory. No dedicated folder will be created for these downloads.


### In case of neither:
- BA will assume that the given URL is a simple video link.
- This will simply download the video at `ba` config and store the result in the base directory.
- At the end BA will ask you, if it should convert ALL `.webm` files in the base directory (excluding subdirectories) to `.ogg`.
