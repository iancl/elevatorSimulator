
Ipad Elevator Simulator
==============

This is an old Elevator Simulator that I just ported to ARC
--------------


The elevator floor indicator only shows the current or next stop. It doesn't show t



Class structure
--------------

- DoorPanel : UIViewController
- DoorPanelManager : NSObject [singleton]
- doors : UIViewController
- doorManager : NSObject [singleton]
- mainPanel : UIViewController
- cageController : UIViewController
- floorController : UIViewController
- mainController : UIViewController

The planned worklow is the following:
--------------

- Home screen will show all the RSS channels in 'cards'. Each card will show the channel info and picture if avaiable

- To see a channel feed list a user will select any channel

- The feedlist channel will show all the feeds and an image if avalable

- If user clicks on any feed item a new view with a webView will slide in and show the article page


Sounds
--------------

- n/a

Graphical Interface
--------------

- Very basic as this is a test only


Animations
--------------

- UIView and CALayer animations

*****

