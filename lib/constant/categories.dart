import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<String> categories = [
  'Estates',
  'Vehicles',
  'Fashion & Beauty',
  'Mobiles',
  'Furniturs',
  'Computers',
  'Gifts',
  'Babies stuff',
  'Motorcycles',
  'Sport',
  'Pharmacies',
  'Services',
  'Malls',
  'Resturant',
  'Cafe',
  'Variants',
];

IconData? categoryIcon(String category) {
  switch (category) {
    case "Estates":
      return FontAwesomeIcons.building;

    case "Vehicles":
      return FontAwesomeIcons.truck;

    case "Fashion & Beauty":
      return FontAwesomeIcons.person;

    case "Mobiles":
      return FontAwesomeIcons.mobile;

    case "Furniturs":
      return FontAwesomeIcons.couch;

    case "Computers":
      return FontAwesomeIcons.laptop;

    case "Gifts":
      return FontAwesomeIcons.gift;

    case "Babies stuff":
      return FontAwesomeIcons.baby;

    case "Motorcycles":
      return FontAwesomeIcons.motorcycle;

    case "Sport":
      return FontAwesomeIcons.volleyball;

    case "Pharmacies":
      return FontAwesomeIcons.capsules;

    case "Services":
      return FontAwesomeIcons.servicestack;

    case "Malls":
      return FontAwesomeIcons.shop;

    case "Cafe":
      return FontAwesomeIcons.mugSaucer;

    case "Resturant":
      return FontAwesomeIcons.utensils;
    case "Variants":
      return FontAwesomeIcons.globe;
  }
  return null;
}
