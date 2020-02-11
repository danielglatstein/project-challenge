I have been learning about using Docker recently, and thought it would be fun to dockerize this app. My hope is that this will make the app easier for you to review. 

# Set up 
I followed the Docker [Quickstart: Compose and Rails](https://docs.docker.com/compose/rails/) guide.

Before starting, install [Docker Desktop](https://docs.docker.com/compose/install/), unless you already have it. 

From the terminal in this application's directory, run 
```
docker-compose build
```

Then run 
```
docker-compose up
```

Finally, you need to create the database. In another terminal, run:
```
docker-compose run web rake db:create
```

Then run 
```
docker-compose run web rake db:migrate
```

Then run 
```
docker-compose run web rake db:seed
```

You should now be able to run tests: 
```
docker-compose run web rspec spec/
```

# Tests
I wanted to do TDD as much as possible. 

To begin, I began by refactoring some of the existing specs: 
+ Convert controller specs to request specs (https://medium.com/just-tech/rspec-controller-or-request-specs-d93ef563ef11)
+ I also updated the feature specs to not check the database. I think it is ok to look into database for something like a unit, or request specs. However, I beleive feature/integration specs should assert against what the user sees.
+ As I began adding features, I tried to add integration, request, and unit testing where appropriate. 
+ TDD was particularly helpful for the `Sort by Likes in Past Hour` task, which was a good challenge to have the scope return records that didn't have likes in past hour. 

# If I had More Time
+ Add more testing around the DogLikesController
+ Capybara + Selenium Chrome Driver work in Docker container
+ Build out React front-end client
+ Build out Dog Serializer and clean up the view
+ Add more testing around the sorting to the request spec
