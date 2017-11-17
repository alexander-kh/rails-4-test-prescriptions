### Rails 4 Test Prescriptions
##### by Noel Rappin

The code from "Rails 4 Test Prescriptions" book, published by The Pragmatic Bookshelf, adjusted to keep all the tests passing in the used development environment.  
Copyrights apply to this code. It may not be used to create training material, courses, books, articles, and the like. Contact the publisher if you are in doubt.  
Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.

* Versions used:
  * Ruby: 2.3.0
  * Rails: 5.0.3
  * RSpec: 3.6
  * Cucumber: 3.0.1

* Database setup:
   ```
   bin/rails db:migrate
   ```

* To run the test suite:

  * Using RSpec testing library:
  
    * unit tests for models, controllers and views
    
    * integration tests using Capybara library
    
    * external service tests using VCR gem
     ```
     bundle exec rspec
     ```
  
  * Using Jasmine testing library:
  
    * JavaScript unit tests
    
    * JavaScript integration tests using Poltergeist driver for Capybara and a headless browser engine PhantomJS
     ```
     bundle exec rake spec:javascript
     ```
  
  * An acceptance test written using Cucumber and Capybara:
     ```
     bundle exec cucumber
     ```