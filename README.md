# photo-backup

A repo of tools to help backup photos.

## Intro

The purpose of this repo is to save money from Google Photos cost. The idea is to backup original quality photos to long-term storage while converting all images in Google account to High Quality (free). If you need to access images or videos quickly to show, you can do this via Google Photos. If you need the original for print or other reasons, then you go into long-term storage.

Initially a Google Takeout can extract all images / videos for download. This will contain folders of each album / day. It will also contain json metadata about each image. We don't care about this metadata as the High Quality images will retain this metadata. If you do need it, there are instructions for that.

Periodically you will accumulate new images that will continue to use your 15GB Google account storage. Google Takeout will not be able to know when you have done a previous Takeout and will re-download all images, with the previously downloaded images in High Quality instead of Original Quality, which is not what you want. You will have to know the point at which you did a Google Takeout and start after that. You can download them by selected all the new photos by month from photos.google.com.

## How To Use

1. First get a BackBlaze account, create a bucket and get your api key.

2. Go to google takeout, prepare the download for just Google Photos, keep the zip files fairly small (~4 GBs). Download the zipped files.

3. Extract the zipped files. Each zipped folder should be fairly small as there are daily upload limits to BackBlaze. Also if the process dies, you will know where to pick it up again.

4. Run the script including the directory containing all the photos / videos:

`bash uploader.sh /Users/jmac/Documents/takeout1`

_NOTE:_ I found renaming all Takeout folders at once was useful so there are no spaces or capital letters. To do this select all extracted zip folders and right click, rename. Use format: `takeout` + index.

## FAQ

### What are BackBlaze's current limits?

Daily around 2500 actions
10GB free storage

### How do I get the metadata from the originals?

The originals do not contain created_date, geolocation data, or any other metadata by default. To do this you will need to retain the original JSON metadata files and merge them into possibly the EXIF data. The JSON metadata has the same filename as the image or video it came from so this should be easy to do with a script.

### How are the originals organized in long-term storage?

The images are dumped into a bucket with no folder structure. The image filenames do contain the date in a numerical format that allow you to search for specific dates. If you want to find a specific image, go to Google Photos and download that image, look at the filename. Then find the original with that filename in long-term storage.
