# Database Application: International Real Estate
An international real estate company has offices around the world.
- Real estate agents can bea ssigned to any of the offices.
- Each house is assigned one office, one seller and one real estate agent.
- Sellers can sell several houses.
- Buyers can buy several houses.

The initial implementation was in a notebook, which thus might provide a smoother experience. However, the below installations allow the same functionality to be run from the terminal (with db_app folder as root directory):

```
python3.6 -m venv .venv
source .venv/bin/activate

pip3 install -r requirements.txt

python3 create.py
python3 insert_data_1.py
python3 insert_data_2.py
python3 query_tables.py
python3 query_data.py
python3 clean_up.py
```

### File explanations:
- create.py: imports relevant libraries, establishes database connection and creates tables
- insert_data_1.py: inserts 'static' data such as houses, agents, buyers, and sellers
- insert_data_2.py: inserts 'dynamic' data such as when a house is sold
- query_tables.py: queries all tables
- query_data.py: queries data according to specific questions
- clean_up.py: closes the session and drops all data
- requirements.txt: loads all necessary requirements
- DB_application.ipynb: the accompanying notebook for the app




### Use of data normalization, indices and transactions

**Data Normalization**
- The database has four base tables (offices, agents, sellers, buyers) and one house listings table that are created initially.
- Three additional tables are populated as sales occur (sales, commissions).
- A summary table of agents' commission is provided in response to (3).
- **1NF**:
    - each column has only one attribute: 'id', 'first_name', 'bathrooms', ...
    - all values in a column are of the same type: defined as  Column(Text), Column(Integer), ...
    - all columns have unique names: 'office_id', 'zipcode'
    - order in which data is stored does not matter: which office/ agent/ listing ... is entered and saved first does not matter (important to note that that does not include dependencies! houselistings that refer to a seller needs to have a seller saved first)
- **2NF**:
    - first normal form: check
    - no partial dependency: columns are only dependent on the primary key, and nothing else. For example, if the Sales table had sellers as a primary key, but sellers could have multiple houses, the entries would not distinguish themselves by the seller. The current table set up has clear and unique primary keys, where no column information depends on more than one key identifier (id)
- **3NF**:
    - second normal form: check
    - no transitive dependency: For example the House table has agent_id, buyer_id and seller_id, all of which are dependent on the house entry id. However, it does not include their names or contact detail, as those attributes are dependent on the agent_id, buyer_id and seller_id themselves. They are stored in the Agent, Buyer and Seller table respectively.


Source: https://www.studytonight.com/dbms/database-normalization.php

**Indices**
- "Every primary key (in every popular database) will be automatically indexed. This is to make sure that testing for a key’s uniqueness (when inserting a new row) is fast." (Professor Philip Sterne, Slack, March 21)
- Any joins occurring in this implementation are based on foreign key constraints, which use the id of another column, which is their already indexed primary key. Thus, for joins, other indices would not increase efficiency.
- For queries, I implemented covering indices for the four base tables (Office, Agent, Seller, Buyer), since their additional information such as name or contact are more often looked up, and when such information is stored in a covering index, it does not need to be looked up in the original table.
- To my understanding, no other indices would improve performance of the queries, since due to the unique primary key that already exists, the main requirements are met. If there were join tables or no unique id primary keys, composite keys could be useful (e.g. offices and agents, which have a many-to-many relationship).


**Transactions**
- Transactions are necessary when an action (e.g. selling a house) leads to multiple edits to the database (e.g. updating the sold status and adding to the Sale database). To ensure that all necessary edits of happen in one go, they are wrapped in a transaction. Either all go through, or none go through.
- This is implemented using the sessionmaker of SQLAlchemy. Tasks are added to the transaction using `session.add(entry)` and executed using `session.commit()`. If the transaction runs into an error, it rolls back to the previous state before the transaction was executed, and the session has to be closed with `session.close()` and retried.
- This database uses transactions when adding the sale of a house (see function house_sale()). A single transaction (1) queries results from the database, (2) adds an entry to the Sale data and (3) adds an entry to the commission table.
- SQLAlchmey's implementation of transactions is ACID: **(A)** tomic, as it is one single unit of a house sale, **(C)** onsistent as changes are not visible before all have been implemented but the old version of the tables are still visible, **(I)** solated as the updates occurr isolated from the database first and keep it intact and **(D)** urable as transactions, once committed, remain committed even if interruptions occur.
