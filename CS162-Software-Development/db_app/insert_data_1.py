from create import *

Base.metadata.create_all(bind=engine)

Session = sessionmaker(bind=engine)
session = Session()

#--------------------------------------------------
# Create offices, agents, sellers and buyers
#--------------------------------------------------


office_keys = ['id', 'location']
office_values = [
    [1001, 'San Francisco'],
    [1002, 'Seoul'],
    [1003, 'Hyderabad'],
    [1004, 'Berlin'],
    [1005, 'Buenos Aires'],
    [1006, 'London'],
    [1007, 'Taipei']]


agent_keys = ['id', 'first_name', 'last_name', 'email']
agent_values = [
    [2001, 'Anna', 'Aruya', 'anna@google.com'],
    [2002, 'Anton', 'Aldi', 'anton@google.com'],
    [2003, 'Ashish', 'Alder', 'ashish@google.com'],
    [2004, 'Angela', 'Anger', 'angela@google.com'],
    [2005, 'Adrian', 'Aldi', 'adrian@google.com'],
    [2006, 'Ari', 'Aro', 'ari@google.com'],
    [2007, 'Anne', 'Arido', 'anne@google.com'],
    [2008, 'Alinga', 'Azon', 'alinga@google.com'],
    [2009, 'Abuli', 'Appo', 'abuli@google.com'],
    [2010, 'Ankita', 'Avush', 'ankita@google.com']]


seller_keys = ['id', 'first_name', 'last_name']
seller_values = [
    [3001, 'Sabine', 'Singer'],
    [3002, 'Sergio', 'Sent'],
    [3003, 'Sasha', 'Sorrow'],
    [3004, 'Stub', 'Stringo'],
    [3005, 'Stella', 'Serg'],
    [3006, 'Sanik', 'Soumka'],
    [3007, 'Soumaya', 'Strash'],
    [3008, 'Sint', 'Sont'],
    [3009, 'Sigma', 'Sigmoid'],
    [3010, 'Stan', 'Stanislav']]


buyer_keys = ['id', 'first_name', 'last_name']
buyer_values = [
    [4001, 'Barbara', 'Bento'],
    [4002, 'Boyu', 'Bland'],
    [4003, 'Brendon', 'Bright'],
    [4004, 'Breston', 'Brush'],
    [4005, 'Brinta', 'Broy'],
    [4006, 'Blent', 'Buq'],
    [4007, 'Boppi', 'Boppal'],
    [4008, 'Ben', 'Bench'],
    [4009, 'Barbie', 'Barb'],
    [4010, 'Bovi', 'Bentie'],
    [4011, 'Bull', 'Bully'],
    [4012, 'Binnie', 'Bun']]


#--------------------------------------------------
# Create house listings and sales
#--------------------------------------------------

house_keys = ['id', 'name', 'office_id', 'agent_id', 'seller_id', 'bedrooms', 'bathrooms', 'listing_price',
             'zipcode', 'listing_date', 'sold']
house_values = [
    [5001, 'Magnificent Mansion', 1001, 2001, 3001, 10, 8, 3000000, 10911, datetime.date(2019, 1, 1), False],
    [5002, 'Handsome House', 1001, 2001, 3001, 4, 2, 120000, 10353, datetime.date(2019, 1, 3), False],
    [5003, 'Comfy Cabin', 1002, 2001, 3002, 2, 1, 90000, 24502, datetime.date(2019, 1, 4), False],
    [5004, 'Awesome Apartment', 1002, 2002, 3003, 4, 2, 600000, 24502, datetime.date(2019, 1, 6), False],
    [5005, 'Random Room', 1003, 2002, 3003, 1, 1, 300000, 33333, datetime.date(2019, 1, 8), False],
    [5006, 'Buggy Bed', 1003, 2003, 3002, 1, 1, 14000, 34519, datetime.date(2019, 1, 12), False],
    [5007, 'Vengeful Villa', 1003, 2003, 3001, 8, 4, 56000, 32025, datetime.date(2019, 1, 19), False],
    [5008, 'Full Flat', 1004, 2003, 3001, 4, 2, 400000, 33333, datetime.date(2019, 1, 20), False],
    [5009, 'Pizza Palace', 1004, 2003, 3001, 12, 3, 5000000, 32025, datetime.date(2019, 1, 20), False],
    [5010, 'Superhigh Skyscraper', 1004, 2003, 3001, 5, 5, 600000, 24502, datetime.date(2019, 1, 22), False],
    [5011, 'Risky Rooftop', 1004, 2003, 3001, 2, 1, 40000, 10911, datetime.date(2019, 1, 23), False],
    [5012, 'Shiny Studio', 1005, 2003, 3001, 3, 1, 29000, 32025, datetime.date(2019, 1, 29), False],
    [5013, 'Crunchy Cellar', 1005, 2003, 3001, 1, 0, 500, 24502, datetime.date(2019, 1, 31), False],
    [5014, 'Magnificent Mansion', 1006, 2003, 3003, 6, 3, 79000, 24502, datetime.date(2019, 1, 31), False]]



#--------------------------------------------------
# Add entries to session
#--------------------------------------------------


keys = [office_keys, agent_keys, seller_keys, buyer_keys, house_keys]
values = [office_values, agent_values, seller_values, buyer_values, house_values]
table_classes = [Office, Agent, Seller, Buyer, House]


def add_entries_to_session(keys, values, table_class):
    list_of_dict = []
    for value in values:
        item_dict = dict(zip(keys, value))
        list_of_dict.append(item_dict)

    for data_entry in list_of_dict:
        entry = table_class(**data_entry)
        session.add(entry)


for i in range(len(table_classes)):
    add_entries_to_session(keys[i], values[i], table_classes[i])

session.commit()
session.close()
