from sqlalchemy import create_engine, Column, Text, Integer, Date, Boolean, ForeignKey
from sqlalchemy import case, func, join, text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker
import pandas as pd
import datetime
import pandas.io.sql as psql

engine = create_engine('sqlite:///database.db')
engine.connect()

Base = declarative_base()


#--------------------------------------------------
# Base Tables
#--------------------------------------------------

class Office(Base):
    __tablename__ = 'offices'
    id = Column(Integer, primary_key = True)
    location = Column(Text, index = True)

    def __repr__(self):
        return "<Office(id={0}, location={1})".format(self.id, self.location)


class Agent(Base):
    __tablename__ = 'agents'
    id = Column(Integer, primary_key = True)
    first_name = Column(Text, index = True)
    last_name = Column(Text, index = True)
    email = Column(Text, index=True)

    def __repr__(self):
        return "<Buyer(id={0}, first_name={1}, last_name={2})".format(self.id, self.first_name, self.last_name)


class Seller(Base):
    __tablename__ = 'sellers'
    id = Column(Integer, primary_key = True)
    first_name = Column(Text, index = True)
    last_name = Column(Text, index = True)

    def __repr__(self):
        return "<Seller(id={0}, first_name={1}, last_name={2})".format(self.id, self.first_name, self.last_name)


class Buyer(Base):
    __tablename__ = 'buyers'
    id = Column(Integer, primary_key = True)
    first_name = Column(Text, index = True)
    last_name = Column(Text, index = True)

    def __repr__(self):
        return "<Buyer(id={0}, first_name={1}, last_name={2})".format(self.id, self.first_name, self.last_name)


#--------------------------------------------------
# House Listings
#--------------------------------------------------


class House(Base):
    __tablename__ = 'houses'
    id = Column(Integer, primary_key = True)
    name = Column(Text)
    office_id = Column(Integer, ForeignKey('offices.id'))
    agent_id = Column(Integer, ForeignKey('agents.id'))
    seller_id = Column(Integer, ForeignKey('sellers.id'))
    bedrooms = Column(Integer, nullable=False)
    bathrooms = Column(Integer, nullable=False)
    listing_price = Column(Integer, nullable=False)
    zipcode = Column(Integer)
    listing_date = Column(Date)
    sold = Column(Boolean)

    def __repr__(self):
        return "<House(id={0}, name={1}, sold={2})>".format(self.id, self.name, self.sold)


#--------------------------------------------------
# Sale, Commission and Summary
#--------------------------------------------------

class Sale(Base):
    __tablename__ = 'sales'
    id = Column(Integer, primary_key = True)
    house_id = Column(Integer, ForeignKey('houses.id'))
    buyer_id = Column(Integer, ForeignKey('buyers.id'))
    sale_price = Column(Integer)
    sale_date = Column(Date)

    def __repr__(self):
        return "<Sale(id={0}, house_id={1}, buyer_id={2})>".format(self.id, self.house_id, self.buyer_id)


class Commission(Base):
    __tablename__ = 'commissions'
    id = Column(Integer, primary_key = True)
    agent_id = Column(Integer, ForeignKey('agents.id'))
    sale_id = Column(Integer, ForeignKey('sales.id'))
    commission = Column(Integer)

    def __repr__(self):
        return "<Commission(id={0}, agent_id={1}, commission={2})>".format(self.id, self.agent_id, self.commission)
