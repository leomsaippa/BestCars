# BestCars
 
BestCars is an app which shows to user a list of best cars according to [Car And Drive](https://www.caranddriver.com/shopping-advice/a35536605/2021-editors-choice/) magazine.


![Login Screen](https://github.com/leomsaippa/BestCars/tree/main/BestCars/Screenshots/login.png)

Logging in the app, it was used Udacity API, so it's necessary to have an Udacity account and setup correctly to run the app. [Here](https://auth.udacity.com/sign-up) you can check more information.


After logging, user can choose between three Tab items:

![Table List](https://github.com/leomsaippa/BestCars/tree/main/BestCars/Screenshots/listcar.png)
1 - A Table list, which allows user to click and see more information in a Detail screen

![Collection List](https://github.com/leomsaippa/BestCars/tree/main/BestCars/Screenshots/collection.png)
2 - A Collection View which shows just basic information about car

![Favorite](https://github.com/leomsaippa/BestCars/tree/main/BestCars/Screenshots/favorite.png)
3 - A favorite Table, which allows user to see cars which was favorited by user

![Detail Screen](https://github.com/leomsaippa/BestCars/tree/main/BestCars/Screenshots/detail.png)
Detail Screen show information about car, like its name, price and a small magazine review

NSUSerDefaults was used in two moments.

1 - To keep user connected, if option "Keep Connected" was selected when LogIn

2 - To save favorite cars and show in the list

To show list of cars, it was created a [Mocked API](https://mockapi.io/) using Car And Drive information. After download data from API, app saves these information using Core Data to avoid need to re-download information every time.

## Build information to run app
iOS Target Version: 14.4
Xcode Version: 12.5
Swift Version: 5.4


### Install

To download project, just run on command line 

```
$ git clone https://github.com/leomsaippa/BestCars
```

#### Author

* **Leonardo Muniz Saippa** - [leomsaippa](https://github.com/leomsaippa)

