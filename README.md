#PlaceReminderApp

An app made with Xcode and Objective C for the mobile programming exam, where you can insert location (either with coordinates or address), save them and view them either on a map or in a list

# Structure
The main files (view controllers, storyboards etc) are present in the PlaceReminderApp/ folder
Ignore folder (ImagesForReadMe)

The two classes MarkerCLass and MarkerList respectively define the individual savable placeholders and the list of placeholders, MarkerClass extends MKAnnotation (and implements the related methods) to allow you to add them as annotations on a map.
  
  ViewController, ListViewController, MapClassViewController and DetailsView are the controllers of the following views respectively:
  
   - Main
   - ListView
   - MapView
   - DetailsScreen

  The map is initialized by default on Parma
  
  (main.storyboard is contained in the PlaceReminderApp/Base.Iproj folder)
  

  # ScreenShots (outdated)
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(3).jpeg)
  
Screen to add a marker (View: Main, Controller: ViewController) by clicking on the map it is possible to see the markers as annotations on the map or, by clicking on the image of the list, as an ordered list.
In case the keyboard doesn't disappear in the emulator when clicking outside a textbox use shift+command+k
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(4).jpeg)
  
Map screen (Controller: MapClassViewController), clicking on the "i" you can see all the information related to the marker
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(1).jpeg)
  
List screen (Controller: ListViewController), the list is sorted by the most recent item, clicking on a cell you can see all the information
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(2).jpeg)
  
 Details view where you can see all information of a marker (Controller:DetailsView) here you can also delete the marker
