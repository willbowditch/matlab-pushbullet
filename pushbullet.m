%==========================================================================
% FUNCTION SENDS A PUSHBULLET NOTE
% - find your API key (AKA Access token)at: 
%   https://www.pushbullet.com/account and set below.
% - use pushbullet('title', 'message') to send push notifications. 
% - Input must be string, so use sprintf to convert variables
%   beforehand. 
% - optional, can also provide api key if you'd rather leave it out of the
%   function (pushbullet('title','message','apikey'))
%==========================================================================

function pushbullet (title, message, apikey)

try
    
if ~exist('message','var')
    message='';
end

if ~exist('apikey', 'var')
    % SET YOUR API KEY HERE, IF YOU DON'T WANT TO INPUT IT EVERY TIME
    apikey='';
end

host='https://api.pushbullet.com/v2/pushes';
params={'type' 'note' 'title' title 'body' message};

%Convert to a URL post String
str = '';
for i=1:2:length(params)
    if (i == 1), separator = '';
    else separator = '&';
    end
    param  = urlencode(params{i});
    value  = urlencode(params{i+1});
    str = [str separator param '=' value]; 
end

assert(usejava('jvm'),'Function requires Java')

import com.mathworks.mlwidgets.io.InterruptibleStreamCopier;
com.mathworks.mlwidgets.html.HTMLPrefs.setProxySettings

%Create a urlConnection
handler = sun.net.www.protocol.https.Handler;
url = java.net.URL([],host,handler);
urlConnection = url.openConnection;
urlConnection.setRequestMethod('POST');
urlConnection.setFollowRedirects(true);
urlConnection.setReadTimeout(0);

%Authorise Connection
encoder = sun.misc.BASE64Encoder();
out = char(encoder.encode(java.lang.String([apikey ':' '']).getBytes()));
urlConnection.setRequestProperty('Authorization', ['Basic ' out]);

%Prepare Data
body = unicode2native(str,'');


%Send!
urlConnection.setRequestProperty('Content-Length',int2str(length(body)));
urlConnection.setDoOutput(true);
outputStream = urlConnection.getOutputStream;
outputStream.write(body);
outputStream.close;
inputStream = urlConnection.getInputStream;

%Finsh up
inputStream.close;
outputStream.close;
urlConnection.disconnect;

catch err
    disp('Warning! Push notification failed... wrong api key? No internet?');
end