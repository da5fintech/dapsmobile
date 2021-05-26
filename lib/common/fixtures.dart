import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';

List<Map<String, dynamic>> billerList = [
  {
    'title': BILLS_PAYMENT_CATEGORIES_SCREEN_AIRLINES_TEXT,
    'imagePath': "assets/svg2/ICONS_AIRLINES.svg",
  },
  {
    'title': BILLS_PAYMENT_BILLER_ELECTRIC_UTILITIES_TEXT,
    'imagePath': 'assets/svg2/ICONS_ELECTRIC_UTILITIES.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_WATER_UTILITIES_TEXT,
    'imagePath': 'assets/svg2/ICONS_WATER_UTILITIES.svg',
  },
  {
    'title': BILLS_PAYMENT_CATEGORIES_SCREEN_UTILITIES_TEXT,
    'imagePath': 'assets/svg2/ICONS_REAL_ESTATE.svg',
  },
  {
    'title': BILLS_PAYMENT_CATEGORIES_SCREEN_CABLE_INTERNET_TEXT,
    'imagePath': 'assets/svg2/ICONS_CABLE_AND_INTERNET.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_LOANS_TEXT,
    'imagePath': 'assets/svg2/ICONS_LOANS.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_CREDIT_CARD_TEXT,
    'imagePath': 'assets/svg2/ICONS_CREDIT_CARD.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_TELECOM_TEXT,
    'imagePath': 'assets/svg2/ICONS_TELECOMM.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_GOVERMENT_TEXT,
    'imagePath': 'assets/svg2/ICONS_GOVERNMENT.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_INSURANCE_TEXT,
    'imagePath': 'assets/svg2/ICONS_INSURANCE.svg',
  },
  {
    'title': BILLS_PAYMENT_CATEGORIES_SCREEN_TRANSPORTATION_TEXT,
    'imagePath': 'assets/svg2/ICONS_TRANSPORTATION.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_SCHOOLS_TEXT,
    'imagePath': 'assets/svg2/ICONS_EDUCATION.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_HEALTH_CARE_TEXT,
    'imagePath': 'assets/svg2/ICONS_HEALTHCARE.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_REAL_ESTATE_TEXT,
    'imagePath': 'assets/svg2/ICONS_REAL_ESTATE.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_FOOD_TEXT,
    'imagePath': 'assets/svg2/ICONS_FOOD_AND_DRINKS.svg',
  },
  {
    'title': BILLS_PAYMENT_CATEGORIES_SCREEN_OTHERS_TEXT,
    'imagePath': 'assets/svg/services/bills-payment/others.svg',
  },
  {
    'title': BILLS_PAYMENT_BILLER_FAVORITES_TEXT,
    'imagePath': 'assets/svg2/ICONS_FAVORITES.svg',
  }
];

List<Map<String, dynamic>> partners = [
  { 'title': PARTNER_MERCHANT_FOOD_TEXT, 'imagePath': 'assets/icons/merchant-partners/food.png'},
  { 'title': PARTNER_MERCHANT_RETAIL_TEXT, 'imagePath': 'assets/icons/merchant-partners/retail.png'},
  { 'title': PARTNER_MERCHANT_ENTERTAINMENT_TEXT, 'imagePath': 'assets/icons/merchant-partners/entertainment.png'},
  { 'title': PARTNER_MERCHANT_PHARMACIES_TEXT, 'imagePath': 'assets/icons/merchant-partners/pharmacies.png'},
  { 'title': PARTNER_MERCHANT_TRANSPORTATION_TEXT, 'imagePath': 'assets/icons/merchant-partners/transportation.png'},
  { 'title': PARTNER_MERCHANT_SUPERMARKET_TEXT, 'imagePath': 'assets/icons/merchant-partners/supermarket.png'},
  { 'title': PARTNER_MERCHANT_STORE_TEXT, 'imagePath': 'assets/icons/merchant-partners/store.png'},
  { 'title': PARTNER_MERCHANT_GADGETS_TEXT, 'imagePath': 'assets/icons/merchant-partners/gadgets.png'},
  { 'title': PARTNER_MERCHANT_SERVICES_TEXT, 'imagePath': 'assets/icons/merchant-partners/services.png'},
];

List recommendedId = [
  "UMiD",
  "Driver's License",
  "Philhealth Card",
  "SSS ID",
  "Passport",
  "Voter's ID",
];

List otherId = [
  "Alien Immigrant COR",
  "Government Office/GOCC ID",
  "HDMF ID (Pag-ibig)",
  "Postal ID",
];


List otcOptions = [
  { "title": "Villarica\nPawnshop", "imagePath": "assets/icons/services/cash-in/villarica.png", "enable": true},
  { "title": "G-Cash", "imagePath": "assets/icons/services/cash-in/gcash.png", "enable": true},
  { "title": "RD\nPawnshop", "imagePath": "assets/icons/services/cash-in/rdpawnshop.png", "enable": true},
  { "title": "7-Eleven", "imagePath": "assets/icons/services/cash-in/7-eleven.png", "enable": true},
  { "title": "Raquel\nPawnshop", "imagePath": "assets/icons/services/cash-in/raquel.png", "enable": true},
];

List bankOptions = [
  { "title": "G-Cash", "imagePath": "assets/icons/services/cash-in/gcash.png", "enable": true},
  { "title": "UnionBank", "imagePath": "assets/icons/services/cash-in/union-bank.png", "enable": false},
  { "title": "BPI", "imagePath": "assets/icons/services/cash-in/bpi.png", "enable": false},
  { "title": "Instapay", "imagePath": "assets/icons/services/cash-in/instapay.png", "enable": false},
  { "title": "Pesonet", "imagePath": "assets/icons/services/cash-in/pesonet.png", "enable": false},
];


List remittanceOptions = [
  { "title": "Western Union", "imagePath": "assets/icons/services/cash-in/wu.png", "enable": false},
  { "title": "Cebuana\nLhullier", "imagePath": "assets/icons/services/cash-in/cebuana.png", "enable": false},
  { "title": "RD Cash\nPadala", "imagePath": "assets/icons/services/cash-in/rd-padala.png", "enable": false},
  { "title": "RIA Money Transfer", "imagePath": "assets/icons/services/cash-in/ria.png", "enable": false},
  { "title": "iRemit", "imagePath": "assets/icons/services/cash-in/iremit.png", "enable": false},
];






