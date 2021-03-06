library constants;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'constants.g.dart';

const APP_NAME = "DAPS";
const APP_NAME_FONT_SIZE = 20.0;
const APP_HELP_CENTER = "Help Center";
const APP_VERSION = "v5.0.1";
const APP_EMAIL = "info@swipe.ph";
const KABOOTEK_URL = "https://kabootekph.co/";

const UPDATE_DIALOG = "IMPORTANT UPDATE!";
const UPDATE_DIALOG_CONTENT_MESSAGE =
    "In order to enjoy using this app securely, please UPDATE to the latest version of our app now!";

const MPIN_RECOVERY_TITLE = "MPIN Recovery";
const MPIN_RECOVERY_CONTENT_MESSAGE =
    "We need to do a 2-step authentication process before resetting your MPIN. We will send a 6-digit code to your registered mobile number.";
const MPIN_RECOVERY_PROCEED = "Proceed";

const ONBOARDING_FIRST_SCREEN_TITLE =
    "The Launch of Your New And Secured E-wallet!";
const ONBOARDING_FIRST_SCREEN_SUB_TITLE =
    "The DAPS app was launched to help people accomplish things easily "
    "without the rush and risk of going outside. This mobile application "
    "is perfect for entrepreneurs and individuals who are looking for "
    "a trusted e-wallet with helpful features.";

const ONBOARDING_SECOND_SCREEN_TITLE =
    "Made perfect for personal and Business transactions";
const ONBOARDING_SECOND_SCREEN_SUB_TITLE =
    "DAPS app offers an easier and secure payment solution to everyone without any hassle. "
    "If you are a homeowner and have utility bills to pay, download the DAPS app and a single "
    "tap on your smartphone will do!";

const ONBOARDING_THIRD_SCREEN_TITLE = "Multiple transactions in one app";
const ONBOARDING_THIRD_SCREEN_SUB_TITLE =
    "Skip the traditional way of dealing with your finances."
    " DAPS app has multiple payment solutions and features that you will enjoy."
    " Once your account is verified, you can start sending or receiving payments from your customers,"
    " shop online, buy load, pay using the hassle-free QR code, and many more. "
    "You do not need to hop on remittance centers, convenience stores, and malls, "
    "to deal with your finances, the DAPS app is all you need!";

const ONBOARDING_FOURTH_SCREEN_TITLE = "Easy-to-use interface for all ages";
const ONBOARDING_FOURTH_SCREEN_SUB_TITLE =
    "Our developers of the DAPS app ensure that its interface fits everyone. "
    "All the buttons, colors, fonts, and redirected pages were all designed very "
    "carefully to give a pleasing yet straightforward appearance for all. "
    "You do not need to feel overwhelmed by the app's design because it is "
    "purposely made to be beginner and user-friendly. "
    "DAPS app is here to help by being your go-to payment solution anytime and anywhere. ";

const LOGIN_SCREEN_LOGIN_TEXT = "LOG IN";
const LOGIN_SCREEN_REGISTER_TEXT = "LOGIN DA5 ACCOUNT";
const LOGIN_SCREEN_SIGN_UP_TEXT = "OR SIGN-UP USING";
const LOGIN_SCREEN_APP_NAME = "DAPS";
const LOGIN_SCREEN_APP_NAME_LETTER_SPACING = 15.0;
const LOGIN_SCREEN_APP_NAME_FONT_SIZE = 20.0;

const LOGIN_EMAIL_SCREEN_EMAIL_TEXT = "Email";
const LOGIN_EMAIL_SCREEN_PASSWORD_TEXT = "Password";
const LOGIN_EMAIL_SCREEN_LOGIN_TEXT = "Log in";
const LOGIN_EMAIL_SCREEN_ALTERNATE_LOGIN_TEXT = "OR LOGIN USING";
const LOGIN_EMAIL_SCREEN_FAILED_ATTEMPT_TEXT = "Login Error";

const LOGIN_FAILED_TITLE = "Try Again!";
const LOGIN_FAILED_SUB_TITLE =
    "There was an error with your login information.";

const VERIFICATION_MAIN_SCREEN = "Your account is in Basic Level";
const VERIFICATION_MAIN_UPGRADE =
    "Verify your account to ensure account security and unlock more DAPS services.";
const VERIFICATION_MAIN_SCREE_STEPS = "Get fully verified in just 3 steps";
const VERIFICATION_MAIN_LABEL_ID = "Take ID Photo";
const VERIFICATION_MAIN_LABEL_SCAN_FACE = "Scan Face";
const VERIFICATIOPN_MAIN_LABEL_INFORMATION = "Personal Information";
const VERIFICATION_MAIN_UNLOCK =
    "After verification, unlock more features like:";
const VERIFICATION_MAIN_LABEL_REMITTANCE = "Remittance";
const VERIFICATION_MAIN_LABEL_SEND_REQUEST = "Send / Request";
const VERIFICATION_MAIN_LABEL_BANK_TRANSFER = "Bank Transfer";
const VERIFICATION_MAIN_LEARN_MORE =
    "Learn more about verification level perks";

const VERIFICATION_PHOTO = "Take ID Photo";
const VERIFICATION_VALID_ID = "Valid IDs";
const VERFICATION_FRONT_ID = "Front of ID";
const VERIFICATION_PLACE_ID =
    "Place your ID within the frame and take a photo.";
const VERIFICATION_PROCEED_id = "Would you like to proceed using this ID?";
const VERIFICATION_NEXT = "NEXT";
const VERIFICATION_RETAKE_PHOTO = "Retake Photo";

const VERIFICATION_SCAN_TITLE = "Scan Face";
const VERIFICATION_TAKE_SELFIE = "Get ready to take a selfie";
const VERIFICATION_NOTE =
    "To fully verify your identity, we need to gather your biological information.";
const VERIFICATION_GUIDE = "Position your face within the frame.";
const VERIFICATION_GUIDE_2 = "You will be automatically scanned.";
const VERIFICATION_GUIDE_3 = "The process will take few seconds.";
const VERIFICATION_NOTE_NEXT = 'Are you ready? Tap "NEXT" to start scanning.';

const PAYQR_SCREEN_TITLE_TEXT = "Pay QR/Barcode";
const PAYQR_SCREEN_UPLOAD_TEXT = "Upload QR";
const PAYQR_SCREEN_GENERATE_QR_TEXT = "Generate QR / Bar code";
const PAYQR_SCREEN_SCAN_TEXT = "DAPS Scan Pay";
const PAYQR_UPLOAD_SCREEN_TITLE = "Photos";
const PAYQR_UPLOAD_TAB_1 = "All Photos";
const PAYQR_UPLOAD_TAB_2 = "Albums";
const PAYQR_GENERATE_TITLE = "Generate Code";
const PAYQR_GENERATE_SCREEN_NOTE_TEXT =
    "Show one of this code to the cashier of any participating\n "
    "merchant to pay your purchase.";

const LOGIN_MPIN_SCREEN_LOGIN_TEXT = 'Login';

const REGISTRATION_SCREEN_SUCCESS_TEXT = "Congratulations";
const REGISTRATION_SCREEN_USER_CREATION_TEXT =
    'We\'ve successfully created your account!';
const REGISTRATION_SCREEN_USER_LOGIN_TEXT = "PROCEED TO LOGIN";
const REGISTRATION_SCREEN_OTP_TITLE_TEXT = "Verify Registration";
const REGISTRATION_SCREEN_INCORRECT_OTP_TEXT = "Invalid OTP! Please try again.";
const REGISTRATION_SCREEN_OTP_GREET = "Welcome to DAPS! \n\n"
    "Enjoy convenience at your fingertips! \n\n"
    "Make sure to verify your account to have access to all the services DAPS has to offer. \n\n"
    "Directly send money to other DAPS users, Transfer money to Bank Accounts, Pay your Bills and many more! \n\n"
    "Do it all with DAPS!";

const REGISTRATION_FAILED_TITLE = "Failed Registration:";
const REGISTRATION_FAILED_DIALOG =
    "Something went wrong! Please contact our support hotline to assist you.";

const USER_PROFILE_SCREEN_TITLE_TEXT = "User Profile";
const USER_PROFILE_SCREEN_NOTE_TEXT =
    "For enhanced account security, keep your account information up to date.";

const SETTINGS_SCREEN_TITLE = "Settings";
const SETTINGS_SCREEN_CHANGE_MPIN_TEXT = "Change MPIN";
const SETTINGS_SCREEN_ACCOUNT_AUTH_TEXT = "Account Authentication";
const SETTINGS_SCREEN_BIOMETRIC_LOGIN_TEXT = "Biometric Login";
const SETTINGS_SCREEN_BIOMETRIC_BANNER_TEXT = "Biometric Log in";
const SETTINGS_SCREEN_BIOMETRIC_BANNER_NOTE_TEXT =
    "Login faster to DAPS using Biometric Authentication";
const SETTINGS_SCREEN_BIOMETRIC_ENABLE_TEXT = "Enable Biometric";
const SETTINGS_SCREEN_BIOMETRIC_NOT_AVAILABLE =
    "Biometric is not available on your device.";
const SETTINGS_SCREEN_BIOMETRIC_DISCLAIMER_TEXT =
    'By enabling Biometric login, you allow DAPS to access your saved\nbiometrics'
    'data on your device to create and save data in DAPS that\n'
    'shall be used for securing your login. The data will not be used for\n'
    'any other purposes.';
const SETTINGS_SCREEN_BIOMETRIC_OTP_GREET = "Fantastic!";
const SETTINGS_SCREEN_BIOMETRIC_OTP_LIMIT = "Please enter your 6-digit OTP.";
const SETTINGS_SCREEN_BIOMETRIC_OTP_SEND =
    "We've sent a 6-digit One Time Password(OTP) to your registered mobile number.";
const SETTINGS_SCREEN_BIOMETRIC_OTP_NEW_CODE = "Need new code?";
const SETTINGS_SCREEN_BIOMETRIC_OTP_RESEND_CODE = "Resend Code";
const SETTINGS_SCREEN_BIOMETRIC_OTP_ENROLL_NOW = "ENROLL NOW";
const SETTINGS_SCREEN_SWIPE_DIALOG_CONFIRMATION = "Confirmation";
const SETTINGS_SCREEN_SWIPE_BIOMETRIC_NOTE_TEXT =
    "DAPS would like to use your Biometric for additional Security.";
const SETTINGS_SCREEN_SWIPE_FACEID_NOTE_TEXT =
    "DAPS would like to use your Face ID for additional Security.";
const SETTINGS_SCREEN_SWIPE_DISABLE_TEXT = "Disable Biometric Login";
const SETTINGS_SCREEN_SWIPE_DISABLE_CONFIRMATION_TEXT =
    "Are you sure you want to disable Biometric login?";
const SETTINGS_SCREEN_CHANGE_PIN_TITLE = "MPIN";
const SETTINGS_SCREEN_INCORRECT_PIN_TITLE = "Incorrect PIN";
const SETTINGS_SCREEN_CHANGE_YOUR_PIN = "Change your MPIN";
const SETTINGS_SCREEN_ENTER_NEW_PIN = "Please enter your new 6-digit MPIN";
const SETTINGS_SCREEN_CONFIRM_PIN_TITLE = "Confirm MPIN";
const SETTINGS_SCREEN_CONFIRM_PIN_BANNER_TITLE = "Confirm you MPIN";
const SETTINGS_SCREEN_RE_CONFIRM_PIN_BANNER_TITLE =
    "Please re-enter your 6-digit MPIN";
const SETTINGS_SCREEN_MPIN_UPDATED_PIN = "MPIN updated";
const SETTINGS_SCREEN_MPIN_UPDATED_SUCCESS_PIN =
    "You have successfully updated your MPIN";

const LINKS_ACCOUNT_SCREEN_TITLE = "Accounts";

const PARTNER_MERCHANT_TITLE_TEXT = "Partner Merchants";
const PARTNER_MERCHANT_SHOP_TEXT = "Find where you can stop";
const PARTNER_MERCHANT_FOOD_TEXT = "Food";
const PARTNER_MERCHANT_RETAIL_TEXT = "Retail";
const PARTNER_MERCHANT_ENTERTAINMENT_TEXT = "Entertainment";
const PARTNER_MERCHANT_PHARMACIES_TEXT = "Pharmacies";
const PARTNER_MERCHANT_TRANSPORTATION_TEXT = "Transportation";
const PARTNER_MERCHANT_SUPERMARKET_TEXT = "Supermarket";
const PARTNER_MERCHANT_STORE_TEXT = "Convenient Store";
const PARTNER_MERCHANT_GADGETS_TEXT = "Gadgets";
const PARTNER_MERCHANT_SERVICES_TEXT = "Services";

const PROMOS_SCREEN_TITLE_TEXT = "Promos";
const PROMOS_SCREEN_TITLE_DO_MORE_TEXT = "Do more with DAPS!";
const PROMOS_SCREEN_TITLE_EXTENDS_TEXT =
    "Increase your wallet limit up to PHP 500K!";
const PROMOS_SCREEN_TITLE_SAVE = "Save for the future!";
const PROMOS_SCREEN_TITLE_ANNUM = "Up to 25% interests per annum.";
const PROMOS_SCEREN_LINK_NOW = "LINK NOW";

const VOUCHER_POCKETS_SCREEN_TITLE = "Voucher Pockets";
const VOUCHER_POCKETS_TAB_1_TITLE = "Active";
const VOUCHER_POCKETS_TAB_2_TITLE = "Used";
const VOUCHER_POCKETS_TAB_3_TITLE = "Expired";
const VOUCHER_POCKETS_NOTE_TEXT =
    "Get voucher by scanning the Promo QR Code, Pay using QR Code, or buying a load with DAPS";
const VOUCHER_POCKETS_INFORMATION_TEXT = "Learn more about voucher";

const SERVICES_SCREEN_VERIFIED_TEXT = "VERIFIED";
const SERVICES_SCREEN_BALANCE_TEXT = "Available balance";
const SERVICES_SCREEN_CASH_IN_TEXT = "Cash In";
const SERVICES_SCREEN_REMITTANCE_TEXT = "Direct Send";
const SERVICES_SCREEN_BANK_TRANSFER_TEXT = "Bank Transfer";
const SERVICES_SCREEN_BUY_LOAD_TEXT = "Buy Load";
const SERVICES_SCREEN_PAY_BILLS_TEXT = "Pay Bills";
const SERVICES_SCREEN_REQUEST_MONEY_TEXT = "Request Money";
const SERVICES_SCREEN_PAY_QR_TEXT = "Pay QR";
const SERVICES_SCREEN_INSURANCE_TEXT = "Insurance";
const SERVICES_SCREEN_MORE_TEXT = "More";
const SERVICES_SCREEN_TRANSACTION_TEXT = "Transaction History";
const SERVICES_SCREEN_ADVANTAGE_DAPS_TEXT = "Know more about DAPS";
const SERVICES_SCREEN_REASON_SWIPE_TEXT = "We can do things better";

const HELP_SCREEN_TITLE_TEXT = "Help";

const CASH_IN_TITLE_TEXT = "Cash In";
const CASH_IN_LINKED_ACCOUNTS_TEXT = "My Linked Accounts";
const CASH_IN_MANAGED_TEXT = "Manage";
const CASH_IN_LINKED_NOTE_TEXT = "Link your accounts for easy access";
const CASH_IN_LINKED_SUBNOTE_TEXT =
    "Connect your accounts with DAPS wallet for\neasy cash-in process.";
const CASH_IN_OTC_TEXT = "Over the Counter";
const CASH_IN_ONLINE_BANK = "Online Bank";
const CASH_IN_REMITTANCE = "Remittance";

const CASH_IN_LOCATION_DIALOG_TITLE = "Allowed Location Permission";
const CASH_IN_LOCATION_DIALOG_CONTENT =
    "In order for us to locate you to our nearby partners we need you allow us access your location.";

const CASH_IN_PARTNER_DETAILS_TITLE = "Partner Details";
const CASH_IN_VIEW_NEARBY_STORES = "View nearby branches";
const CASH_IN_GENERATE_BARCODE = "Generate Barcode";
const CASH_IN_SUBNOTE_BARCODE =
    "Have the cashier scan this barcode linked to your DAPS account.";
const CASH_IN_HOW_TO_CASH = "How to Cash In";
const CASH_IN_HOW_TO_CASH_SUBNOTE =
    "You can cash in at any available branch of our official partners.";
const CASH_IN_STEP_1 =
    "Inform the cashier that you would like to ???Cash In??? to your DAPS wallet.";
const CASH_IN_STEP_2 =
    'Tap on the ???Generate Barcode??? button above. Enter the amount that you wish to cash in then tap ???Next???.';
const CASH_IN_STEP_3 =
    "The cashier will confirm if the barcode was accepted, collect the payment and print the receipt.";

const CASH_IN_VIA_CODE = "Cash In via Code";
const CASH_IN_VIA_CODE_SUBNOTE =
    "Cash In made easier via Barcode\nor a unique Reference Code";
const CASH_IN_VIA_CODE_DONE = "Done";
const CASH_IN_VIA_CODE_NEXT = "Next";
const CASH_IN_VIA_CODE_DOWLOAD = "Download";
const CASH_IN_VIA_CODE_AMOUNT_VALIDATION =
    "Please check the amount before you proceed";
const CASH_IN_DOWNLOAD_CODE = "Photo has been Saved to the Gallery";

const DIRECT_SEND_SCREEN_TITLE_TEXT = "Send / Request Money";
const DIRECT_SEND_SCREEN_SWIPE_SEND_TEXT =
    "Send Money to another DAPS account";
const DIRECT_SEND_SCREEN_DIRECT_SEND_TEXT = "Direct Send";
const DIRECT_SEND_SCREEN_SEND_QR_TEXT = "Send Via QR";
const DIRECT_SEND_SCREEN_SEND_TO_BANK_TEXT = "Send Money to Bank Account";
const DIRECT_SEND_SCREEN_BANKS_TEXT = "Banks";
const DIRECT_SEND_SCREEN_REMITTANCE_TEXT = "Send Money to Remittance Center";
const DIRECT_SEND_SCREEN_REMITTANCE_CENTERS_TEXT = "Remittance Centers";

const DIRECT_SEND_FORM_SCREEN_MOBILE = "Mobile Number";
const DIRECT_SEND_FORM_NOTE_MOBILE = "*Phone format recipient e.g 9012345678";
const DIRECT_SEND_FORM_SCREEN_AMOUNT = "Amount";
const DIRECT_SEND_FORM_SCREEN_MESSAGE = "Message";
const DIRECT_SEND_FORM_SCREEN_MESSAGE_OPTIONAL = "*Message optional";
const DIRECT_SEND_FORM_SCREEN_NEXT = "NEXT";
const DIRECT_SEND_TEXT = "Direct Send";

const DIRECT_REQUEST_FORM_SCREEN_TITLE = "My Custom QR";
const DIRECT_REQUEST_FORM_SCREEN_NICKNAME = "Nickname (Optional)";
const DIRECT_REQUEST_FORM_SCREEN_SAVE = "Save";

const DIRECT_SEND_VIA_QR_SCREEN_TITLE = "Send Via QR";
const DIRECT_SEND_VIA_QR_SCREEN_NOTE = 'Align QR code to the frame to\n'
    'start scanning.\n\n'
    'SCAN QR CODE';
const DIRECT_SEND_VIA_QR_SCREEN_DETECTED = "QR Code detected!";
const DIRECT_SEND_VIA_QR_SCREEN_RESCAN = "Re-scan QR Code";
const DIRECT_SEND_VIA_QR_SCREEN_PROCEED = "PROCEED";

const BILLS_PAYMENT_TITLE_TEXT = "Pay Bills";
const BILLS_PAYMENT_NEXT_TEXT = "Next";
const BILLS_PAYMENT_SCREEN_IMMEDIATE_POST_TEXT =
    "Payment will be posted immediately";
const BILLS_PAYMENT_BILLER_SCREEN_ALL_BILLERS_TEXT = "All Billers";
const BILLS_PAYMENT_CATEGORIES_SCREEN_SAVED_BILLERS_TEXT = "Recent Biller(s)";
const BILLS_PAYMENT_CATEGORIES_SCREEN_ADD_BILLER_TEXT = "Add Biller";
const BILLS_PAYMENT_CATEGORIES_SCREEN_DELETE_BILLER_TEXT =
    "Are you sure you want to delete";
const BILLS_PAYMENT_CATEGORIES_SCREEN_AIRLINES_TEXT = "Airlines";
const BILLS_PAYMENT_CATEGORIES_SCREEN_CABLE_INTERNET_TEXT = "Cable / Internet";
const BILLS_PAYMENT_CATEGORIES_SCREEN_ELECTRICITY_TEXT = "Electricity";
const BILLS_PAYMENT_CATEGORIES_SCREEN_INSURANCE_TEXT = "Insurance";
const BILLS_PAYMENT_CATEGORIES_SCREEN_TRANSPORTATION_TEXT = "Transportation";
const BILLS_PAYMENT_CATEGORIES_SCREEN_ONLINE_SHOPPING_TEXT = "Online Shopping";
const BILLS_PAYMENT_CATEGORIES_SCREEN_UTILITIES_TEXT = "Utilities";
const BILLS_PAYMENT_CATEGORIES_SCREEN_WATER_TEXT = "Water";
const BILLS_PAYMENT_CATEGORIES_SCREEN_OTHERS_TEXT = "Others";
const BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TITLE =
    "All Billers (Transportation)";
const BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TEXT = "Autosweep";
const BILLS_PAYMENT_TRANSPORTATION_POSTED_IMMEDIATELY =
    "Payment will be posted immediately";
const BILLS_PAYMENT_TRANSPORTATION_PLATE_NUMBER_TEXT = "Plate Number";
const BILLS_PAYMENT_TRANSPORTATION_AMOUNT_TEXT = "Amount";
const BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_1 = "Autosweep";
const BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_2 = "Easytrip";
const BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_3 = "Beep";

const BILLS_PAYMENT_BILLER_LIST_TITLE_TEXT = "Add Biller";
const BILLS_PAYMENT_BILLER_ELECTRIC_UTILITIES_TEXT = "Electric";
const BILLS_PAYMENT_BILLER_WATER_UTILITIES_TEXT = "Water";
const BILLS_PAYMENT_BILLER_LOANS_TEXT = "Loans";
const BILLS_PAYMENT_BILLER_CREDIT_CARD_TEXT = "Credit Card";
const BILLS_PAYMENT_BILLER_TELECOM_TEXT = "Telecom";
const BILLS_PAYMENT_BILLER_GOVERMENT_TEXT = "Government";
const BILLS_PAYMENT_BILLER_INSURANCE_TEXT = "Insurance";
const BILLS_PAYMENT_BILLER_SCHOOLS_TEXT = "Schools";
const BILLS_PAYMENT_BILLER_HEALTH_CARE_TEXT = "Health Care";
const BILLS_PAYMENT_BILLER_REAL_ESTATE_TEXT = "Real Estate";
const BILLS_PAYMENT_BILLER_FOOD_TEXT = "Food";
const BILLS_PAYMENT_BILLER_FAVORITES_TEXT = "Favorites";

const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_SEND_TEXT = "Send Money";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_PAYMENT_POSTED_TEXT =
    "Payment will be posted immediately";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_AMOUNT_TEXT = "Amount";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_ACCOUNT_TEXT = "Account";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_RECIPIENT_TEXT = "Recipient";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_NEXT_TEXT = "Next";
const REMITTANCE_INSTAPAY_BANK_SCREEN_SELECT_BANK_TEXT = "Select Bank";

const AUTH_MERCHANT_ID = "0910";
const AUTH_NETWORK_ID = "0625";
const AUTH_USERNAME = "kabootekph";
const AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const API_ENDPOINT = "https://accounts.daps.ph/web/index.php";
// const API_ENDPOINT = "https://directagent5.com.ph/daps/index.php";

const AUTOSWEEP_AUTH_MERCHANT_ID = "0910";
const AUTOSWEEP_AUTH_NETWORK_ID = "0625";
const AUTOSWEEP_AUTH_USERNAME = "kabootekph";
const AUTOSWEEP_AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const AUTOSWEEP_API_ENDPOINT = "https://accounts.daps.ph/web/index.php";

const BILLS_PAYMENT_AUTH_MERCHANT_ID = "0910";
const BILLS_PAYMENT_AUTH_NETWORK_ID = "0625";
const BILLS_PAYMENT_AUTH_USERNAME = "kabootekph";
const BILLS_PAYMENT_AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const BILLS_PAYMENT_API_ENDPOINT = "https://accounts.daps.ph/web/index.php";

const E_LOADING_AUTH_MERCHANT_ID = "0910";
const E_LOADING_AUTH_NETWORK_ID = "0625";
const E_LOADING_AUTH_USERNAME = "kabootekph";
const E_LOADING_AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const E_LOADING_API_ENDPOINT = "https://accounts.daps.ph/web/index.php";

const INSTAPAY_AUTH_MERCHANT_ID = "0910";
const INSTAPAY_AUTH_NETWORK_ID = "0625";
const INSTAPAY_AUTH_USERNAME = "kabootekph";
const INSTAPAY_AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const INSTAPAY_API_ENDPOINT = "https://accounts.daps.ph/web/index.php";

const DIRECT_PAY_AUTH_MERCHANT_ID = "0910";
const DIRECT_PAY_AUTH_NETWORK_ID = "0625";
const DIRECT_PAY_AUTH_USERNAME = "kabootekph";
const DIRECT_PAY_AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const DIRECT_PAY_API_ENDPOINT = "https://directagent5.com.ph/daps/index.php";
const DIRECT_PAY_API_STAGING_ENDPOINT =
    "https://accounts.daps.ph/web/index.php";
const DIRECT_PAY_SCOPE = "remittance";

const PESONET_PAY_AUTH_MERCHANT_ID = "0910";
const PESONET_PAY_AUTH_NETWORK_ID = "0625";
const PESONET_PAY_AUTH_USERNAME = "kabootekph";
const PESONET_PAY_AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const PESONET_PAY_API_ENDPOINT = "https://directagent5.com.ph/daps/index.php";
const PESONET_PAY_API_STAGING_ENDPOINT =
    "https://accounts.daps.ph/web/index.php";
const PESONET_PAY_SCOPE = "pesonet";
const PESONET_PAY_FEE = 25.00;

const UNION_BANK_ENDPOINT =
    "https://api-uat.unionbankph.com/partners/sb/customers/v1/oauth2";
const UNION_BANK_CLIENT_ID = "f783917c-507f-4423-81b8-b76beb061a45";
const UNION_BANK_RESPONSE_TYPE = "code";
const UNION_BANK_SCOPE = "account_info";
const UNION_BANK_REDIRECT_URI = "https://hard-eel-41.loca.lt/oauth/redirect";
const UNION_BANK_STATE = '{"at": "test_state_transfer"}';
const UNION_BANK_LINKING = "linking";
const UNION_BANK_PARTNER_ID = "5dff2cdf-ef15-48fb-a87b-375ebff415bb";

const BPI_BANK_ENDPOINT = "https://oauth.bpi.com.ph/bpi/api/oauth2/authorize?response_type=code&client_id=71939b76-ec62-43c8-94b3-5c81c93722e2&redirect_uri=https://accounts.daps.ph/web/index.php/&scope=transactionalAccountsForBillsPay";
const BPI_MAIN_ENDPOINT = "https://accounts.daps.ph/web/index.php";
const BPI_NETWORK_ID = "5678";
const BPI_MERCHANT_ID = "1234";
const BPI_USERNAME = "testonly";
const BPI_AUTHENTICATION = "6c093c3205e252b43c36b22124549bfc6b625efd";
const BPI_SCOPE = "banks";

const CASHIN_MERCHANT_ID = "";
const CASHIN_NETWORK_ID = "";
const CASHIN_USERNAME = "";
const CASHIN_SIGNATURE = "";
const CASHIN_ENDPOINT = "https://api.swipe.ph";

const GCASH_MERCHANT_ID = "1234";
const GCASH_NETWORK_ID = "5678";
const GCASH_USERNAME = "testonly";
const GCASH_AUTH_SIGNATURE = "6c093c3205e252b43c36b22124549bfc6b625efd";
const GCASH_ENDPOINT = "https://accounts.daps.ph/staging/index.php";
const GCASH_SCOPE = "gcash";
const GCASH_REFERENCE = "100035";
const GCASH_FEE = "10";

const VERIFY_MERCHANT_ID = "";
const VERIFY_NETWORK_ID = "";
const VERIFY_USERNAME = "";
const VERIFY_SIGNATURE = "";
const VERIFY_ENDPOINT = "https://api.swipe.ph";

const SMS_USERNAME = "itda5";
const SMS_PASSWORD = "@da5_isms-2019";
const SMS_API = "https://www.isms.com.my/isms_send.php?";

const PH_SERVICE_ENDPOINT = "https://api.swipe.ph";

const ELOADING_SCOPE = 'eloading';
const BILLS_PAYMENT_SCOPE = 'billspayment';
const BILLS_PAYMENT_CHANNEL = 'X2B2';
const INSTAPAY_SCOPE = 'instapay';

const REMITTANCE_SCREEN_CATEGORIES_BANK_TEXT = "Banks";
const REMITTANCE_SCREEN_CATEGORIES_WALLET_TEXT = "Wallets";
const REMITTANCE_SCREEN_CATEGORIES_CENTERS_TEXT = "Remittance Centers";
const REMITTANCE_SCREEN_PANEL_SEND_MONEY_TEXT = "Send Money via:";
const REMITTANCE_SCREEN_PANEL_SEND_INSTANCE_FREE_TEXT =
    "Send Instantly for free";
const REMITTANCE_SCREEN_PANEL_SEND_OTHER_BANKS_TEXT =
    "Send to other Banks and Wallets, Received instantly";
const REMITTANCE_SCREEN_PANEL_CUT_OFF_TEXT = "No Cutoff";
const REMITTANCE_SCREEN_PANEL_TRANSACTION_LIMIT = "50,000.00 Transaction Limit";
const REMITTANCE_SCREEN_PANEL_SEND_FOR_FREE = "Send for Free";
const REMITTANCE_SCREEN_PANEL_SEND_TO_OTHER_BANKS_INSTANCE_TEXT =
    "Send to other Banks and Wallets, Receive by end of the day";
const REMITTANCE_SCREEN_PANEL_TRANSACTION_NOTE =
    "Transactions before 3:00 PM cut-off are processed same banking day. Transactions after cut-off, weekends of holidays are processed the next banking day";
const REMITTANCE_SCREEN_TITLE_TEXT = "Send/Request Money";
const REMITTANCE_SCREEN_TAB_SEND_TEXT = "Send";
const REMITTANCE_SCREEN_TAB_REQUEST_TEXT = "Request";

const TRANSACTION_HISTORY_SCREEN_TITLE_TEXT = "Transaction History";
const TRANSACTION_HISTORY_SCREEN_BUTTON_ALL_TEXT = "ALL";
const TRANSACTION_HISTORY_SCREEN_BUTTON_RECEIVED_TEXT = "RECEIVED";
const TRANSACTION_HISTORY_SCREEN_BUTTON_SENT_TEXT = "SENT";
const TRANSACTION_HISTORY_SCREEN_DETAILS_TEXT = "Details";
const TRANSACTION_HISTORY_SENT_TEXT = "Sent to:";
const TRANSACTION_HISTORY_AMOUNT_TEXT = "Amount to:";
const TRANSACTION_HISTORY_END_BALANCE_TEXT = "Ending Balance:";
const TRANSACTION_HISTORY_DATE_TIME_TEXT = "Date & Time:";
const TRANSACTION_HISTORY_REFERENCE_TEXT = "Reference No.:";

const REGISTER_MPIN_SCREEN_SET_PIN_TEXT = "Set your Mobile Pin";
const REGISTER_MPIN_SCREEN_NOTE_TEXT =
    "MPIN is a 6 digit security code which is used to authenticate "
    "login request and transactions."
    "\n\nNote: Please avoid using weak MPINs such as your "
    "Birthdate, 123456 or 888888.";
const REGISTER_MPIN_SCREEN_TEXT = "MPIN";
const REGISTER_SCREEN_FIRSTNAME_TEXT = "First Name";
const REGISTER_SCREEN_LASTNAME_TEXT = "Last Name";
const REGISTER_SCREEN_ADDRESS_TEXT = "Address";
const REGISTER_SCREEN_BIRTHDAY_TEXT = "Birth Date";
const REGISTER_SCREEN_BIRTHDAY_FORMAT = "MM/DD/YY";
const REGISTER_SCREEN_MOBIILE_TEXT = "Mobile Number";
const REGISTER_SCREEN_EMAIL_TEXT = "Email";
const REGISTER_SCREEN_PASSWORD_TEXT = "Password";

const PAYMENT_CONFIRMATION_SCREEN_TITLE_TEXT = "Receipt";
const PAYMENT_CONFIRMATION_SCREEN_RECEIVED_TEXT = "Payment Received";
const PAYMENT_CONFIRMATION_SCREEN_TRANSACTION_TEXT = "Transaction";
const PAYMENT_CONFIRMATION_SCREEN_SENT_TEXT = "Sent to";
const PAYMENT_CONFIRMATION_SCREEN_AMOUNT_TEXT = "Amount";
const PAYMENT_CONFIRMATION_SCREEN_FEE_TEXT = "Fee";
const PAYMENT_CONFIRMATION_SCREEN_DUE_TEXT = "Amount due";
const PAYMENT_CONFIRMATION_SCREEN_DATE_TEXT = "Date";
const PAYMENT_CONFIRMATION_SCREEN_REF_TEXT = "Reference No";
const PAYMENT_CONFIRMATION_SCREEN_PROCESSED_TEXT =
    "Your payment is being processed. \n You will receive a text message regarding this transaction.";
const PAYMENT_CONFIRMATION_SCREEN_DONE_TEXT = "DONE";
const PAYMENT_MPIN_SCREEN_TITLE = "Payment";
const PAYMENT_MPIN_SCREEN_GREET = "Fantastic";
const PAYMENT_MPIN_SCREEN_DIGIT_LIMIT =
    "Please enter your 6-digit MPIN to proceed.";
const PAYMENT_MPIN_SCREEN_PROCEED_TEXT = "PROCEED";
const PAYMENT_VERIFICATION_SCREEN_LOAD_FOR_TEXT = "Buy Load for";
const PAYMENT_VERIFICATION_SCREEN_MY_NUMBER_TEXT = "Number";
const PAYMENT_VERIFICATION_SCREEN_PAY_BILLS_TEXT = "Pay Bills for";
const PAYMENT_VERIFICATION_SCREEN_FEE_TEXT = "Fee";
const PAYMENT_VERIFICATION_SCREEN_SEND_MONEY_TEXT = "Send Money For";
const PAYMENT_VERIFICATION_SCREEN_SEND_VIA_TEXT = "Send Via";
const PAYMENT_VERIFICATION_SCREEN_ACCOUNT_NUMBER_TEXT = "Account Number";
const PAYMENT_VERIFICATION_SCREEN_RECIPIENT_TEXT = "Recipient Name";
const PAYMENT_VERIFICATION_SCREEN_PAY_WALLET_TEXT = "Pay with wallet";
const PAYMENT_VERIFICATION_SCREEN_BALANCE_TEXT = "Available Balance";
const PAYMENT_VERIFICATION_SCREEN_ABOUT_TO_PAY_TEXT = "You are about to pay";
const PAYMENT_VERIFICATION_SCREEN_DUE_TEXT = "Amount Due";
const PAYMENT_VERIFICATION_SCREEN_DISCOUNT_TEXT = "Discount";
const PAYMENT_VERIFICATION_SCREEN_VOUCHER_TEXT = "No available voucher";
const PAYMENT_VERIFICATION_SCREEN_TOTAL_AMOUNT_TEXT = "Total Amount";
const PAYMENT_VERIFICATION_AGREE_TERMS_TEXT = "I agree to the ";
const PAYMENT_VERIFICATION_TERMS_CONDITION_TEXT = "Terms & Conditions";
const PAYMENT_VERIFICATION_NOTE_TEXT =
    "Please make sure that all the details above are correct before proceeding to payment.";
const PAYMENT_VERIFICATION_WARNING_TEXT =
    "If you agree please check the terms & condition";
const PAYMENT_VERIFICATION_SCREEN_PAY_TEXT = "Pay";
const PAYMENT_PROCESSING_INVALID_TEXT = "Ooops";
const PAYMENT_PROCESSING_INVALID_INPUT_TEXT =
    "You have entered an incorrect\nMPIN. Please try again,";
const PAYMENT_PROCESSING_CONFIRM_TEXT = "OK";

const DRAWER_MENU_SCREEN_VIEW_NOW = "Verify Now";
const DRAWER_MENU_SCREEN_BASIC_LEVEL = "Basic Level";
const DRAWER_MENU_SCREEN_SEMI_VERIFIED = "Semi Verified";
const DRAWER_MENU_SCREEN_FULLY_VERIFIED = "Fully Verified";
const DRAWER_MENU_SCREEN_LINK_ACCOUNTS = "My Account";
const DRAWER_MENU_SCREEN_PARTNER_MERCHANTS = "Partner Merchants";
const DRAWER_MENU_SCREEN_PROMOS = "Promos";
const DRAWER_MENU_SCREEN_VOUCHER = "Voucher Pocket";
const DRAWER_MENU_SCREEN_SETTINGS = "Settings";
const DRAWER_MENU_SCREEN_HELP = "Help";
const DRAWER_MENU_SCREEN_LOGOUT = "Log out";

const BUY_LOAD_TITLE_TEXT = "Buy Load";
const BUY_LOAD_MOBILE_TEXT = "Mobile";
const BUY_LOAD_PHP_TEXT = "PHP";
const BUY_LOAD_NEXT_TEXT = "Next";
const BUY_LOAD_RECIPIENT_SCREEN_LOAD_FOR_TEXT = "Buy load for:";

const BUY_LOAD_AMOUNT_SCREEN_TAB_OPTION_1 = "Regular Load";
const BUY_LOAD_AMOUNT_SCREEN_TAB_OPTION_2 = "Load Promos";
const BUY_LOAD_AMOUNT_SCREEN_AMOUNT_TEXT = "Amount";
const BUY_LOAD_AMOUNT_ENTER_AMOUNT_OPTION = "Select an amount between 10-1000";
const BUY_LOAD_AMOUNT_ENTER_AMOUNT_OPTION_OR = "or choose Load promo below:";

const SOON_RELEASED_SCREEN_FEATURED_TEXT = "Feature not yet released";
const SOON_RELEASED_SCREEN_NOTE_TEXT =
    "Soon to be released!\nPlease Wait for the updates.";
const SOON_RELEASED_SCREEN_OK_TEXT = "OK";

const VERIFIED_DIALOG_SCREEN = "You are not verified!";
const VERIFIED_DIALOG_SCREEN_UPDATE_TEXT =
    "Please update your user information.";
const VERIFIED_DIALOG_SCREEN_CANCEL = "CANCEL";
const VERIFIED_DIALOG_SCREEN_GO_TO_VERIFY = "GO TO VERIFICATION";

const BLUR_RADIUS = 10;
const COLOR_LIGHT_PURPLE = Color(0xffF9F8FC);
const COLOR_DARK_PURPLE = Color(0xff7A3CDF);
const COLOR_ORANGE = Color(0xffF2A819);
const COLOR_DARK_ORANGE = Color(0xffFF8000);
const COLOR_GREEN = Color(0xff25BA96);
const COLOR_GRAY = Color(0xffC4C4C4);
const COLOR_BLUE = Color(0xff46C4F2);
const COLOR_DARK_GRAY = Color(0xff545454);
const COLOR_GLOBE_BLUE = Color(0xff46C4F2);
const COLOR_SMART_GREEN = Color(0xff25BA96);
const COLOR_DANGER = Color(0xffeb4034);
const COLOR_DAPS = Color(0xff3F51B5);

const INSTAPAY_SENDER_NAME = 'SWIPE INSTAPAY';
const INSTAPAY_ADDRESS1 = 'Torino';
const INSTAPAY_ADDRESS2 = 'Buenavista 1';
const INSTAPAY_CITY = 'General Trias';
const INSTAPAY_PROVINCE = 'Cavite';
const INSTAPAY_ZIP = '4107';
const INSTAPAY_COUNTRY = 'Philippines';
const INSTAPAY_CURRENCY = 'PHP';
const INSTAPAY_FEE = 25.00;

const AUTOSWEEP_TRANSACTION_TYPE = "AUTOSWEEP";
const AUTOSWEEP_SCOPE = "autosweep";
const AUTOSWEEP_PRODUCT_NAME = "Autosweep RFID";
const AUTOSWEEP_FEE = 10.00;
const AUTOSWEEP_VERIFICATION_TEXT_CONTAINER_COLOR = Color(0xff7A3CDF);
const AUTOSWEEP_VERIFICATION_TEXT_CONTAINER_OPACITY = .05;
const AUTOSWEEP_VERIFICATION_TEXT = "Buy Load For";
const AUTOSWEEP_VERIFICATION_TEXT_COLOR = Color(0xff7A3CDF);
const AUTOSWEEP_VERIFICATION_TEXT_COLOR_OPACITY = .87;
const AUTOSWEEP_VERIFICATION_TEXT_FONT_WEIGHT = FontWeight.w500;
const AUTOSWEEP_VERIFICATION_TEXT_PAY_FOR = "Plate Number";
const AUTOSWEEP_VERIFICATION_TEXT_FEE = "Fee";

const kUpdateDialogKeyName = 'kUpdateDialogKeyName';

const MaterialColor themeColor = MaterialColor(
  _themeColorPrimaryValue,
  <int, Color>{
    50: Color(0xFFe6f7ff),
    100: Color(0xFFccefff),
    200: Color(0xFF99dfff),
    300: Color(0xFF66cfff),
    400: Color(0xFF33beff),
    500: Color(_themeColorPrimaryValue),
    600: Color(0xFF008bcc),
    700: Color(0xFF006999),
    800: Color(0xFF004666),
    900: Color(0xFF002333),
  },
);
const int _themeColorPrimaryValue = 0xFF00aeff;

Widget appbarBackground = Container(
  decoration: appbarBgDecor,
);

List<Shadow> shadowLight = <Shadow>[
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 3.0,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 8.0,
    color: Color.fromARGB(125, 0, 0, 50),
  ),
];

List<Shadow> shadowHard = <Shadow>[
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 1.0,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 3.0,
    color: Color.fromARGB(125, 0, 0, 50),
  ),
];

BoxDecoration appbarBgDecor = BoxDecoration(
  color: Colors.black,
);

TextStyle pageTitleWhite = GoogleFonts.roboto(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);

TextStyle secondaryButtonText = GoogleFonts.roboto(color: Colors.white);
TextStyle primaryButtonText = GoogleFonts.roboto(color: COLOR_DARK_PURPLE);

final appBarTheme = AppBarTheme(
    textTheme: TextTheme(headline6: pageTitleWhite),
    color: COLOR_DAPS,
    elevation: 2,
    shadowColor: Colors.grey,
    centerTitle: false,
    actionsIconTheme: IconThemeData(color: Colors.white));

ThemeData createTheme(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: COLOR_DARK_PURPLE,
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.white,
      textTheme: TextTheme(
        headline5: GoogleFonts.roboto(),
        headline6: GoogleFonts.roboto(),
        bodyText2: GoogleFonts.roboto(
          color: Colors.black,
        ),
        bodyText1: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
        headline4: GoogleFonts.roboto(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        headline3: GoogleFonts.roboto(),
        headline2: GoogleFonts.roboto(),
        headline1: GoogleFonts.roboto(),
        subtitle2: GoogleFonts.roboto(),

        // used in text fields
        subtitle1: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
        caption: GoogleFonts.roboto(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.6))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.6))),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelStyle: GoogleFonts.roboto(
            fontSize: 16, color: Colors.white.withOpacity(0.6)),
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.white,
              // secondary will be the textColor, when the textTheme is set to accent
              secondary: COLOR_DARK_PURPLE)));
}

ThemeData createThemePurpleOnWhite(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.white,
      textTheme: TextTheme(
        headline5: GoogleFonts.roboto(),
        headline6: GoogleFonts.roboto(),
        bodyText2: GoogleFonts.roboto(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: Colors.black.withOpacity(.6),
        ),
        bodyText1: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
        headline4: GoogleFonts.roboto(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        headline3: GoogleFonts.roboto(),
        headline2: GoogleFonts.roboto(),
        headline1: GoogleFonts.roboto(),
        subtitle2: GoogleFonts.roboto(),

        // used in text fields
        subtitle1: GoogleFonts.roboto(
            color: Colors.black.withOpacity(.6), fontSize: 16),
        button: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
        caption: GoogleFonts.roboto(),
      ),
      toggleableActiveColor: COLOR_DARK_PURPLE,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(.6))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.5)),
        labelStyle: GoogleFonts.roboto(fontSize: 14, color: COLOR_DAPS),
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.white.withOpacity(.6),
        ),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: COLOR_DAPS,
          textTheme: ButtonTextTheme.primary,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: COLOR_DARK_PURPLE,
              // secondary will be the textColor, when the textTheme is set to accent
              secondary: Colors.white)));
}

@HiveType(typeId: 10)
enum SwipeServiceOffering {
  @HiveField(0)
  BUY_LOAD,
  @HiveField(1)
  CASH_IN,
  @HiveField(2)
  PAY_QR,
  @HiveField(3)
  DIRECT_SEND,
  @HiveField(4)
  REMITTANCE,
  @HiveField(5)
  REMITTANCE_INSTAPAY,
  @HiveField(6)
  BILLS_PAYMENT,
  @HiveField(7)
  INSURANCE,
  @HiveField(8)
  BANK_TRANSFER,
  @HiveField(9)
  REQUEST_MONEY,
  @HiveField(10)
  AUTOSWEEP,
  @HiveField(11)
  MORE,
  @HiveField(12)
  REMITTANCE_PESONET
}

enum OtpServiceAction {
  UPDATE_USER,
  ENABLE_FINGERPRINT,
  REGISTRATION,
  FORGOT_MPIN
}

Map<SwipeServiceOffering, String> SwipeServiceRoutes = {
  SwipeServiceOffering.BUY_LOAD: '..'
};

NumberFormat formatter = NumberFormat.currency(name: 'PHP ', decimalDigits: 2);
NumberFormat formatterWithoutPHP =
    NumberFormat.currency(name: " ", decimalDigits: 2);
NumberFormat formatterInt =
    NumberFormat.currency(name: " ", decimalDigits: 0, customPattern: "###");

DateFormat dateformatter = DateFormat("M/d/y");