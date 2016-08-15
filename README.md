## Distributing booking application
What we have done based on basic preliminary application:

- All methods, comments and some UI parts have been translated.
- Some parts of codes to match better quality refactored.
- ConnectionHandler class added to support very bottom layer of our distributed databases - Connections, updated and select queries.
- Another new implementation of ResultSet added to project to support retrieving results from multiple database connections.
- DistributionUtils class implemented to support our basic operations regarding distributions.

### How it works?
Current application is configured to distribute using 2 **MySQL** databases (servers) and a **PostgreSQL** database. You can add any other database configuration at any time, you just need to update ConnectionHandler and add your own configurations. Also adding more databases while we have some records in our database is possible without breaking relations or loosing data.

We've changed ID format for all tables as follow: _{distributionKey}_:_UUID_ like:
<br />
02:6ef57a4c-1587-47f2-9d95-38eb7fff52f2
<br />
So by parsing each ID we can understand the database address and retrieve the record(s) or add another related record to that database.

Choosing database to add new records into, are based on new registrations. Whenever a new user tries to register to our application we will look for database with minimum number of users, We will generate a new ID for that user with distribution key of the database and further records related to that user will be inserted into its database (by parsing user id we can find the target database).

Queries without conditions to find the target database will be executed on all connected databases so if you run a select query, it will return the result as a customized ResultSet object which will use all connected databases to retrieve records.

### How to setup
Clone the git repository and open it via IntelliJ or Eclipse. Also you need to import _mysql.sql_ and _postgresql.sql_ files. You can change your database configurations from ConnectionHandler class.
<br />
Also checkout server-release branch to see some changes we've done to deploy the application.