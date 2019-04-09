import os
import unittest

import sys
# topdir = os.path.join(os.path.dirname(__file__), "..")
# sys.path.append(topdir)
from app import app, db


class BasicTests(unittest.TestCase):

    ############################
    #### setup and teardown ####
    ############################

    # executed prior to each test
    def setUp(self):
        app.config["TESTING"] = True
        app.config["DEBUG"] = False
        self.app = app.test_client()

    # executed after each test
    def tearDown(self):
        pass

    def test_main_page(self):
        response = self.app.get('/', follow_redirects=True)
        self.assertEqual(response.status_code, 200)

    def test_add_valid(self):
        response = self.app.post(
          '/add',
          data = dict(text="1+1", value="1+1=2")
          follow_redirects=True
        )
        self.assertEqual(response.status_code, 200)



# Integration tests using mock services
# https://stackoverflow.com/questions/51560850/how-to-unit-test-a-post-method-in-python
import json

from unittest import TestCase
from unittest.mock import patch

import requests


class TestAnalytics(TestCase):

    @patch('requests.post')
    def test_post(self, mock_post):
        info = {"text": "1+1", "value": "1+1=2"}
        resp = requests.post("/add", data=json.dumps(info))
        mock_post.assert_called_with("/add", data=json.dumps(info))


TestAnalytics().test_post()
