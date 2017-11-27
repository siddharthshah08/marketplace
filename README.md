# Market place for self-employed
Ruby on rails based application with capability of posting projects and bidding for those projects with the help of REST API. 

### Prerequisites
1. ruby (version >= 2.3.1)
2. rails (version >= 5.1.4)

[Install ruby on rails](http://railsapps.github.io/installing-rails.html) has detailed explanation on the installation of ruby and rails on any OS platform.

### Installing and running the application
1. Download the project directory.
2. cd into the project ``` cd marketplace-api```
3. Install all the required gem files for the application using the command ``` bundle install ``` on the command line. 
4. run ``` rails s OR rails server``` command to start the server.
5. Server runs on port 3000 and can be accessed using the url 
``` e.g. localhost:3000/projects```
6. Logging is done in log/development.log

### Requirements this project meets.

1. Project consists of four main classes Project, Buyer, Seller and Bid. Buyer and Seller are inherited from a parent class called User via [single table inheritance](http://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html). Attributes for all these classes are mentioned below in the API end-points section.
2. The API will respond to five different kinds of HTTP requests: create a resource, read a resource, update a resource, delete a resource, and list a collection of resources.
3. Lowest bid is returned when a project is queried with project id.
4. Query on projects returns most recent 100 projects. Querying on project supports pagination with links to previous, next, last and first page in the header 'Link'. It is done with the query parameters **page** and **per_page**. [Github reference](https://developer.github.com/v3/#pagination) (Pagination implemented only for Projects at this point.)
```
1. <http://localhost:3000/projects?page=1&per_page=30>; rel="first", 
2. <http://localhost:3000/projects?page=2&per_page=30>; rel="prev", 
3. <http://localhost:3000/projects?page=4&per_page=30>; rel="next", 
4. <http://locahost:3000/projects?page=34&per_page=30>; rel="last"
```
5. Status of the bid changes from 'Open' to 'Closed' if it is the lowest bid and the deadline for accepting bid is met.
6. Data is returned in serialized form
``` e.g. get request on a seller will also get all the projects that seller has posted in a single query.```
```
{
    "id": 6,
    "uname": "corporiss_2",
    "projects": [
        {
            "id": 21,
            "name": "Watto",
            "description": "Laboriosam odit rerum reprehenderit.",
            "status": "Inactive",
            "starts_at": "2017-11-27T06:08:32.534Z",
            "ends_at": "2017-12-07T06:08:32.534Z",
            "accepting_bids_till": "2017-11-27T04:08:32.534Z"
        }
    ]
}
```
7. Version 2 implements retriving of sub-resources in URL (only for seller and projects)
``` e.g. localhost:3000/sellers/2/projects/10 ```

Status code responses 
    1. 200 Ok - When request is successful and returned with desired results.
    2. 201 Created - When request to create new record is successful.
    3. 204 No content - Request went through successfully and returned with no content.
    4. 400 Bad Request - The request has malformed/unrecognized syntax or is missing required information for processing the request.
    5. 404 Not Found The resource does not exist at this time. 
    6. 422 Unprocessable Entity Invalid Properties for create/update.
    7. 500 Internal Server Error An unexpected/unrecoverable error happened at the server.

### Assumptions and constraints
1. Multiple bids can be made by single buyer.
2. Bids cannot be altered.
3. All requests must come using content-type application/json
4. Project table have will have a **starts_at** and **ends_at date**. Meaning project is expected to start and end at these date/time. Buyers can bid at per hour (**Hourly**)  rate OR at fixed price (**Fixed_rate**). If the bid is made in **Hourly** the bid amount is calculated as
 ``` (ends_at - starts_at) * per_hour_rate * 8 ```
i.e number of days times rate times 8 hours/per.
5. All bidding is done in USD and value stored is rounded to two decimal places.
6. Date and time format YYYY-MM-DDThh:mm:ssZ

### API End - points
###### GET    /sellers
###### POST   /sellers 
```:uname and :password are required fields and uname has to be unique.```
```
{
  "uname": "doloremques_0",
  "password": "Simple123_",
  "email": "sample@email.com"
}
```
###### GET    /sellers/:id
###### PATCH  /sellers/:id
###### PUT    /sellers/:id
###### DELETE /sellers/:id
###### GET    /buyers
###### POST   /buyers
###### GET    /buyers/:id
###### PATCH  /buyers/:id
###### PUT    /buyers/:id
###### DELETE /buyers/:id
###### GET    /bids
###### POST   /bids - 
```project_id, buyer_id and rate are required fields.```
``` 
{
	"project_id": 1,
	"buyer_id":21,
	"rate": 22,
	"rate_type":"Fixed"
}
```
###### GET    /bids/:id
###### DELETE /bids/:id
###### GET    /projects
###### POST   /projects 
``` :name, :description, :starts_at, :ends_at, :accepting_bids_till are required fields```
``` ends_at should be after the starts_at date and accepting_bids_till cannot be more than one hour before start day```
```
{
        "name": "Anakin Skywalker",
        "description": "Cupiditate est et aliquam cumque tenetur.",
        "status": "Inactive",
        "starts_at": "2017-11-27T06:09:08.565Z",
        "ends_at": "2017-12-07T06:09:08.565Z",
        "accepting_bids_till": "2017-11-27T04:09:08.565Z"
}
```
###### GET    /projects/:id
###### PATCH  /projects/:id
###### PUT    /projects/:id
###### DELETE /projects/:id

### Testing 

Sample data is loaded in a sqlite file using FactoryGirl gem (to create records) and Faker gem (to populate these records).

Unit testing is done using **rspec** framework. All the spec files can be found in ``` spec/controllers/requests``` and ``` spec/models/ ``` directories.
run ``` bundle exec rspec ``` command to run all the tests.



### Built With

Uses SQLite as database and Puma as web server.
```
ruby - 2.3.1 
rails - 5.1.4
sqlite - 3.6.20 (default for rails 5 or >)
puma - 3.11.0 (default for rails 5 or >)   
```

