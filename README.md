#The Pivot
For this 3 week long assignment we were tasked with changing a restaurant menu app into an e-commerce site similar to Etsy.
The project we pivoted from [can be found here](https://github.com/AllPurposeName/dinner_dash).

##Usage
To run locally: 
pull the repo down
run `bundle install`
run `rails s`

The project is still live at http://handmeups.herokuapp.com/

##Goals
We focused primarily on the following:
* Implementing multitenancy
* Pushing the logic down the stack
* Refactoring the cart
* Adding mailer functionality
* Pivoting the database

##Takeaways
We learned quite a bit on this project. One large takeaway was the concept of technical debt. It's best to do things right the first time and be sure to go the extra mile to provide a robust test suite for each feature you implement. Breaking and then subsequently fixing tests was annoying, but it was very relieving to know the new code wasn't just covered, but also wasn't breaking other parts of the app.

Another big takeaway was the importance of pushing logic down the stack. Most of our refactoring efforts came from moving controller logic down into the models. It was a lesson we had been taught pragmatically, but dealing with the situation while on a deadline really drove the message home. Knowing how to fix the wrong way will influence the basic architecture of our future projects.
