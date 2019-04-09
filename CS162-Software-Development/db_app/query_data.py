from create import *

Session = sessionmaker(bind=engine)
session = Session()

### 1. Top 5 offices with most sales
stmt = session.query(
    House.office_id,
    Office.location,
    func.count(House.office_id)
     ).join(Office).filter(House.sold == True).group_by(House.office_id).limit(5)

print(pd.read_sql(stmt.statement, session.bind))


### 2. Top 5 estate agents who sold the most (contact details and sales details)
stmt = session.query(
    Agent.id,
    Agent.first_name,
    Agent.last_name,
    Agent.email,
    func.count(House.agent_id)
     ).join(House).filter(House.sold == True).group_by(Agent.id).limit(5)

print(pd.read_sql(stmt.statement, session.bind))


### 3. Commission of each estate agent
summary = session.query(
    Agent.first_name,
    Agent.last_name,
    Commission.agent_id,
    func.count(Commission.agent_id),
    func.sum(Sale.sale_price),
    func.sum(Commission.commission)).group_by(Agent.id). \
        join(Commission).join(Sale).statement

print(pd.read_sql(summary, session.bind))


### 4. Average number of days a house was on the market
# Unfortunately, I did not manage to find out how to get at
# the average number of days. I researched a lot, but the
# combination of SQLAlchemy + Sqllite seems to be a bit tricky.
# Below are different versions I tried, and here is a conversation
# around the problem: https://stackoverflow.com/questions/1385393/how-to-get-sqlalchemy-storing-datetime-as-julianday-in-sqlite?rq=1

# HOW I USE DATES: house_sale(5010, 4008, 2005, datetime.date(2019, 8, 1))

stmt = session.query(
    House.listing_date,
    Sale.sale_date,
    # func.datediff(text('month'), Sale.sale_date, House.listing_date)
    # func.trunc((extract('epoch', Sale.sale_date) - extract('epoch', House.listing_date)) / 60)
    # func.datediff('month', Sale.sale_date, House.listing_date)
    func.julianday(Sale.sale_date, House.listing_date)
     ).join(Sale)

print(pd.read_sql(stmt.statement, session.bind))


### 5. Average selling price of a house
stmt = session.query(
    func.avg(Sale.sale_price)
     ).one()[0]

print('Average selling price:', stmt, 'USD')


### 6. Zip codes with top 5 average selling price
# extend: order by

stmt = session.query(
    Office.location,
    House.zipcode,
    func.avg(Sale.sale_price)
     ).join(House).join(Sale). \
    filter(House.sold == True).group_by(House.zipcode).limit(5)

print(pd.read_sql(stmt.statement, session.bind))
