# ParkingLot

ParkingLot is a web application that I started in the first half of my time at the Turing School of Software & Design.  During each of the 4 modules we go through, there is space on the side of the whiteboards designated as the "parking lot."  Any questions that students have which don't relate to the current lesson or would be better answered later, go into this section of the whiteboard.

The problem I saw is that there is no recording of the answer, so if a student is out that day, they miss the answer.  I decided to incorporate this question and answer design into a web application, so that students could reference past questions and answers, and also as a way to practice Rails CRUD (as this was relatively new to us at this point in our Turing careers).

## Production Site  
[https://parking-lot.herokuapp.com](https://parking-lot.herokuapp.com)

## Navigating the App  
When a user requests the root page, it will automatically bring them to the questions index page which is the front page of the app.  The user can review all questions from this page, a blue outline around the card indicates that an instructor has answered the question.
<img width="1440" alt="screen shot 2018-09-29 at 10 19 57 am" src="https://user-images.githubusercontent.com/32905782/46248048-4b144180-c3d1-11e8-9549-1ae8d4a74f2f.png">  

Each question card can be clicked on in order to view the question show page.  This page will show you the question, answer (if answered), comments and sub-comments.  Only logged in users can post questions, comments and sub-comments, while admins can post answers, comments and sub-comments.  
User question show:  
<img width="1440" alt="screen shot 2018-09-29 at 11 05 53 am" src="https://user-images.githubusercontent.com/32905782/46248530-a8ab8c80-c3d7-11e8-95ae-b52ed6d4326c.png">
Admin question show:  
<img width="1440" alt="screen shot 2018-09-29 at 11 06 52 am" src="https://user-images.githubusercontent.com/32905782/46248541-cbd63c00-c3d7-11e8-8edb-4065ed00cf4c.png">

Unregistered users can view all questions, answers, comments and sub-comments, but may not create any.  In order to do so, they must log in or register (right side of navigation bar).  
Log in:  
<img width="1440" alt="screen shot 2018-09-29 at 11 09 40 am" src="https://user-images.githubusercontent.com/32905782/46248580-3c7d5880-c3d8-11e8-88bf-d1b40a31ec04.png">
Register:  
<img width="1440" alt="screen shot 2018-09-29 at 11 09 33 am" src="https://user-images.githubusercontent.com/32905782/46248586-56b73680-c3d8-11e8-8c3c-7190058e4a0d.png">

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This application was created in Rails v5.1.6, utilizing Ruby v2.4.1. 

### Installing

Clone the project down locally to your machine.  
```
git clone https://github.com/JPLynch35/parking_lot.git
```  
Inside the project directory, prepare the gems for development with bundler.  
```
bundle install
``` 
Now create the database, prep the migrations, and load the seed data.
```
rake db:{create,migrate,seed}
``` 

## Running the tests

This application is tested with RSpec.  In order to run this test suite, simply call upon RSpec in the terminal while in the project folder.  
```
rspec
```

## Built With

* Ruby 2.4.1- The code language
* Rails 5.1.6- Ruby's web framework
* Google's Materialize- CSS framework for styling
* BCrypt- password hashing

## Authors

* **JP Lynch**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
