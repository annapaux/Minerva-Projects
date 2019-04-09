from create import *

Session = sessionmaker(bind=engine)
session = Session()

def house_sale(house_id, buyer_id, agent_id, sale_date):
    '''Adds a sale to a transaction and commits it to the database. '''

    # Find initial listing price
    listing_price = session.query(House.listing_price).filter(House.id == house_id).first()[0]

    # Add agent's commission
    bracket = case([(House.listing_price < 100000, 0.01),
           (House.listing_price < 200000, 0.075),
           (House.listing_price < 500000, 0.06),
           (House.listing_price < 1000000, 0.05),
           (House.listing_price > 1000000, 0.04),])
    agent_commission = session.query(House.listing_price*bracket).filter(House.id == 5001).first()[0]

    # Calculate sale price
    sale_price = listing_price + agent_commission

    # Add Sale entry (id autoincrements)
    sale_entry = Sale(
        house_id = house_id,
        buyer_id = buyer_id,
        sale_price = sale_price,
        sale_date = sale_date)
    session.add(sale_entry)


    # Mark house as sold in House table
    house_sold = session.query(House).filter(House.id == house_id)
    house_sold.update({House.sold: True})


    # Add commission entry (id autoincrements)
    sale_id = session.query(Sale.id).filter(House.id == house_id).first()[0]

    commission_entry = Commission(
        agent_id = agent_id,
        sale_id = sale_id,
        commission = agent_commission)
    session.add(commission_entry)

    # Commit the transaction
    session.commit()


# Add house sales (house_id, buyer_id, agent_id, sale_date))

house_sale(5001, 4001, 2001, datetime.date(2019, 4, 1))
house_sale(5002, 4002, 2001, datetime.date(2019, 5, 1))
house_sale(5003, 4003, 2001, datetime.date(2019, 5, 1))
house_sale(5004, 4004, 2002, datetime.date(2019, 6, 1))
house_sale(5005, 4005, 2002, datetime.date(2019, 4, 1))
house_sale(5006, 4006, 2003, datetime.date(2019, 4, 1))
house_sale(5007, 4007, 2003, datetime.date(2019, 7, 1))
house_sale(5008, 4007, 2004, datetime.date(2019, 7, 1))
house_sale(5009, 4008, 2004, datetime.date(2019, 8, 1))
house_sale(5010, 4008, 2005, datetime.date(2019, 8, 1))
