import requests
import json
from rasa_core_sdk import Action


class ActionMyFallback(Action):
  def name(self):
    return "my_fallback_action"

  def run(self, dispatcher, tracker, domain):
    dispatcher.utter_template("utter_under_building")
    return []
