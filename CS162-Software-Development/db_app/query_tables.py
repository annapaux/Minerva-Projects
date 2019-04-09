from create import *

Session = sessionmaker(bind=engine)
session = Session()

table_classes = [Office, Agent, Seller, Buyer, House, Commission, Summary]
table_names = ['Office', 'Agent', 'Seller', 'Buyer', 'House', 'Commission', 'Summary']

for i in range(len(table_classes)):
    print(table_names[i])
    print(pd.read_sql(session.query(table_classes[i]).statement, session.bind))
    print('-' * 20)
