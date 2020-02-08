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

You should now be able to run tests: 
```
docker-compose run web rspec spec/
```

# Tests
I wanted to do TDD as much as possible. 

To begin, I began by refactoring some of the existing specs: 
+ Convert controller specs to request specs (https://medium.com/just-tech/rspec-controller-or-request-specs-d93ef563ef11)
