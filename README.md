# Daniele_Ziaco_PlaceReminderApp
Un app per salvare marker  geografici fatta in xcode per l'esame di programmazione di sistemi mobili

# Struttura
I file principali (I view controller, storyboard ecc) sono presenti nella cartella PlaceReminderApp/
Ignorare la cartella (ImagesForReadMe)

Le due classi MarkerCLass e MarkerList definiscono rispettivamente i singoli segnaposto salvabili e la lista di segnaposto, MarkerClass estende MKAnnotation (e implementa i relativi metodi) per permettere di aggiungerli come annotazioni su una mappa.
  
 ViewController, ListViewController, MapClassViewController e DetailsView sono i controller rispettivamente delle seguenti viste:
  
  - Main
  - ListView
  - MapView
  - DetailsScreen

 La mappa viene inizializzata di default su Parma
  
 (main.storyboard è contenuta nella cartella PlaceReminderApp/Base.Iproj)
  

  # ScreenShots
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(3).jpeg)
  
  Schermata per aggiungere un marker (View: Main, Controller: ViewController) cliccando sulla mappa è possibile vedere i marker come annotazioni sulla mappa oppure, cliccando sull'immagine della lista, come lista ordinata.
  In caso la tastiera non sparisca nell'emulatore cliccando fuori da una textbox usare shift+command+k
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(4).jpeg)
  
  Schermata dellla mappa (View: MapView nella rispettiva storyboard, Controller: MapClassViewController), cliccando sulla "i" è possibile vedere tutte le informazioni relative al marker
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(1).jpeg)
  
  Schermata lista (View: ListView nella storyboard main.storyboard, Controller: ListViewController), la lista è ordinata dall'elemento più recente, cliccando su una cella è possibile vedere tutte le informazioni
  
  ![](https://github.com/ErZicky/Daniele_Ziaco_PlaceReminderApp/blob/main/ImagesForReadMe/screen%20(2).jpeg)
  
  Schermata dei dettagli dove è possibile vedere tutte le informazini di una marker (View: Detailsview nella rispettiva storyboard, Controller:DetailsView) qui è possibile anche eliminare il marker
