DemoWebviewApsalar_ios
======================

A demo webview iOS app integrating Apsalar SDK

Refer to:
http://support.apsalar.com/customer/portal/articles/772167

1. Before event tracking in webview, You need to integerate Apsalar Android SDK.
(import apsala.jar into app/libs/, etc...)

 Refer to:
 http://support.apsalar.com/customer/portal/articles/717510

1. Change API key and secret in AppDelegate.swift

	```Apsalar.startSession("<API KEY>", withKey: "<SECRET>", andURL:url)```

1. Change API key in assets/www2/level2.html
	```"{'ps': '<API KEY>'...```
