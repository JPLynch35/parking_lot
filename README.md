# ParkingLot (WIP)

ParkingLot is a web application that I started in the first half of my time at the Turing School of Software & Design.  During each of the 4 modules we go through at the school, there is space on the side of the whiteboards designated as the 'Parking Lot.'  Any questions that students have which don't relate to the current lesson or would be better answered later, go into this section of whiteboard.  The problem I saw is that there is no recording of the answer, so if a student is out that day, they miss the answer.  I decided to incorporate this question and answer design into a web application, so that students could reference past questions and answers, and also as a way to practice Rails CRUD (as this was relatively new to us at this point in our Turing careers).

## Navigating the App  
When a user requests the root page, it will automatically bring them to the questions index page which is the front page of the app.  The user can review all questions from this page, a blue outline around the card inidicates that an instructor has answered the question.
<img width="1440" alt="screen shot 2018-09-29 at 10 19 57 am" src="https://user-images.githubusercontent.com/32905782/46248048-4b144180-c3d1-11e8-9549-1ae8d4a74f2f.png">  

Each question card can be clicked on in order to view the question show page.  This page will show you the question, answer and comments.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This application was created in Rails v5.1.6, utilizing Ruby v2.4.1. 

### Installing

Clone the project down locally to your machine.  
```
git clone https://github.com/JPLynch35/bar_hop_buddy.git
```  
Inside the project directory, prepare the gems for development with bundler.  
```
bundle install
``` 

## Running the tests

This application is tested with RSpec.  In order to run this test suite, simply call upon RSpec in the terminal while in the project folder.  
```
rspec
```

## Built With

* Ruby 2.4.1- The code language
* Rails 5.1.6- Ruby's web framework
* Semantic UI- Front end framework for styling
* jQuery- JavaScript library
* OmniAuth Google OAuth2- Logging in utilizing a Google account
* MapBox- API for reverse geolocation and creating maps
* Chart.js- API for creating charts
* NewRelic- Performance analytics (removed due to Heroku memory issues)

## Authors

* **JP Lynch**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
