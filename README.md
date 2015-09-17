# matlab-pushbullet
Matlab function that sends push notifications using the Pushbullet API

## Usage
To send a notification simply call `pushbullet('title','message','acesstoken')`.

Alternatively, you can edit `pushbullet.m` to use the same accesstoken each time allowing you to use `pushbullet('title','message')` or  `pushbullet('title')` (just sending the title causes a single line notification). 

Fetch your access token at [pushbullet.com/account](http://pushbullet.com/account)

## Notes
This function does not use matlab's urlread function, as I had some issues with it on older versions. 

Tested on OSX only. 
