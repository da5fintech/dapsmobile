import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';

class TermsAndCondtionScreen extends StatelessWidget {
  final type;

  TermsAndCondtionScreen({@required this.type});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: type == 'terms' ? "Terms Condition" : "Privacy Policy",
        ),
        body: Markdown(data: type == 'terms' ? terms : privacy),
      )
    );
  }
}

const privacy = """

**Background**

This privacy policy sets out the commitment of DA5 and KabootekPH to collect and process personal information, how we may use this information, and other important topics relating to your privacy and data protection in accordance with applicable laws and regulations relating to data privacy such as the Philippine Data Privacy Act of 2012 and its IRR. This company respects and values your data privacy rights, and makes sure that all personal data collected from you are processed in adherence to the general principles of transparency and legitimate purpose. It also applies to personal informationDA5 and KabootekPH may otherwise collect though our  **DAPS APP**, through our products   and   services,   and   business   Partners.Information   that   we   receive   from customers, whether constituting personal data, are generally protected as privileged communications, and covered by our responsibility to our customers to keep that information confidential.

**Definitions**

**“DPA”** means the Data Privacy Act of 2012 and its implementing rules and regulations,as well as the circulars issued by the National Privacy Commission from time to time;

**“Personal Data”** means personal information and sensitive personal information;

**"Personal Information"** refers to any information, whether recorded in a material for more not, from which the identity of an individual is apparent or can be reasonably and directly ascertained by the entity holding the information, or when put together with other information, would directly and certainly identify an individual;

**"Policy"** means this data privacy policy as may be amended, modified or supplemented from time to time;

**"Processing"** refers to any operation or any set of operations performed upon personaldata   including,   but   not   limited   to,   the   collection,   recording,   organization,   storage,updating, or modification, retrieval, consultation, use, consolidation, blocking, erasure,or destruction of data. Processing may be performed through automated means, ormanual processing, if the personal data are contained or are intended to be contained ina filing system;

**"Sensitive   Personal   Information"**  refers   to   personal   information:   (1)   about   an individual’s race, ethnic origin, marital status, age, color, and religious, philosophical or political affiliations; (2) about an individual’s health, education, genetic or sexual life of a person, or to any proceeding for any offense committed or alleged to have been committed by such individual, the disposal of such proceedings, or the sentence of any court in such proceedings; (3) issued by government agencies peculiar to an individual which includes, but is not limited to, social security numbers, previous or current health records, licenses or its denials, suspension or revocation, and tax returns; or (4)specifically  established  by  an   executive   order  or  an   act   of  Congress  to  be   kept classified; 

**Processing of Personal Data** 

This company collects the basic contact information of clients and customers, including their full name, address, email address, contact number, together with the products that they would like to avail in the DAPS APP. 

This company will ensure that personal data under its custody are protected against any accidental or unlawful destruction, alteration and disclosure as well as against any other unlawful processing. The company will implement appropriate security measures in storing collected personal information, depending on the nature of the information. 

Due to the sensitive and confidential nature of the personal data under the custody of the company, only the client and the authorized representative of the company shall be
allowed to access such personal data, for any purpose, except for those contrary to law,public policy, public order or morals. Furthermore, all employees and personnel of the company shall maintain the confidentiality and secrecy of all personal data that come to their knowledge and possession, even after resignation, termination of contract, or other contractual relations. 

Personal data under the custody of the company shall be disclosed only pursuant to a lawful purpose, and to authorized recipients of such data.

**Security Measure**

This company will endeavor to ensure that personal data in our possession or under our control are protected against unauthorized access, collection, use, disclosure, copying, modification, disposal or similar risks.The designated Data Protection Officer is Mr. Alfred Tolentino, who is concurrently serving as the Monitoring Supervisor the Compliance and Training Department of DA5.The Data Protection Officer shall oversee the compliance of the DAPS APP with the DPA, its IRR, and other related policies.

**Inquiries and Complaints** 

Data subjects/ Customers may inquire or request for information regarding any matter relating   to   the   processing   of   their   personal   data   under   the   custody   of   DA5   and KabootekPH, including the data privacy and security policies implemented to ensure the protection of their personal data. For your information about how to contact KabootekPHand   DA5.,   please   visit  https://da5.com.ph.   You   may   likewise   coordinate   with   our customer support at info@swipe.ph, or customer.support@da5.com.ph / 02 88958195.

**Amendments and supplements** 

We reserve the right to amend or supplement this Privacy Policy consistent with Data Privacy Laws of the Philippines. You agree to be bound by the prevailing terms of this Policy as updated from time to time with or without notice and will indicate any updates in this App. 

**Consent** 

Submitting your data signifies that you have read and understood this Privacy Notice and expressly consent to the processing of your personal and/or sensitive personal information in the manner and for the purpose provided in this Notice. You understand and accept that this will include access to personal data and records submitted, which may be regarded as personal and/or sensitive personal data as provided under the Data Privacy Act of 2012. Consenting to this Privacy Notice, however, does not waive any of your right sunder the Data Privacy Act of 2012.
""";


const terms = """
**TERMS AND CONDITIONS**

Welcome to the Daps Application. This Application is provided by Direct Agent 5 and KabootekPH Inc. By registering/using to our service, you agree to the terms and conditions contained in this Terms of Service as well as additional terms and conditions which may subsequently apply to you. Please read them carefully. The following T&Cs shall govern the terms under which you may access and use the products of Daps and the services associated with it.  
Daps reserves the right to modify these T&Cs at any time without any advance notice. Any changes to these T&Cs will be effective immediately upon posting on this page, with an updated effective date. 

**TERMS**

Direct Agent 5, Inc. – A company duly registered with the Bangko Sentral ng Pilipinas (BSP) as a licensed remittance agent. It offers cash in and cash out services, mobile air-time top ups, remittance services, bill payments and Virtual Currency exchange (hereinafter “DA5 Services”
Kabootekph- A company duly registered with the Bangko Sentral ng Pilipinas (BSP) acting as a partner of Direct Agent 5 in providing………..
“Know Your Customer” or “KYC” shall refer to the process of verifying the identity of the customer as required by the BSP.
“Mobile Personal Identification Number” or “MPIN” shall refer to the four (4)-digit security personal identification number of, and nominated for the Daps Customer that is used for all Daps transactions. 
Online Payments – Refers to the payment made by an online merchant over the internet. 
Daps App - the Daps Service application running on mobile devices where the customer can avail of the Daps Services or make use of the Daps Wallet.
Daps Wallet – An e-money instrument that is used, but are not limited to, payments of goods and services, transfer funds and mobile airtime top-ups. It is not a deposit account, and not covered by the Philippine Deposit Insurance Corporation (PDIC). It does not earn interest.

**REGISTRATION FOR A DAPS ACCOUNT**

You will be asked to provide information such as your complete name, address, date of birth, nationality, source of funds, Identification Card as provided below, in accordance with the requirements of Know-Your-Customer (“KYC”) requirements of the BSP. By accepting this terms and conditions, you are agreeing to provide necessary information for registration and verification of your identification details. Likewise, we may require you to provide additional details or information for further verification of your identity.

**VERIFICATION FOR A DAPS ACCOUNT**

To verify your identity, you will be asked to submit a clear photo of your valid identification card. Make sure to take a photo of your ID showing your face and your signature. Failure to submit clear images will result in to delay in your verification. 
The following are the identification cards Daps app accepts:

* Passport
* Driver’s license
* Voter’s ID
* Professional Regulation Commission (PRC) ID
* National ID
* National Bureau of Investigation (NBI) Clearance
* Police Clearance
* Postal ID
* Social Security Service (SSS) Card
* Senior Citizen Card
* Company ID


DA5 and KabootekPh reserve the right to terminate, suspend or limit your access to your Daps Wallet and/or Services in the event that we are unable to obtain or verify our information. All collection and use of your personal data by us is subject to the Data Privacy Act of the Philippines.

**WARRANTIES AND DISCLAIMER** 

DA5 and KabootekPh provide its Services using a commercially reasonable level of skill and care for the provision of efficient assistance in respect of your payment transactions. Other than as expressly set out herein or under additional terms as may be subsequently stipulated by Daps Terms and Conditions and to the extent permitted by the law. Daps does not make any warranty about our service which is provided “as is”. 

**LIABILITY FOR OUR SERVICE**

To the extent permitted by the Law, Daps App shall not be responsible for lost profits, revenue, data financial loss or any indirect special, consequential, exemplary or punitive damages arising from the use of the Daps Application. The total liability which Daps may be held in accountable relative to any claims under this Agreement shall be limited to the relevant transaction amount paid to us using the online bills pay service. 
In no case shall DA5 be liable for any loss or damage resulting from force majeure or any circumstances which is beyond the reasonable contemplation and control of DA5 and KabootekPH and totally independent of the will of the human beings, the consequences of which could not be reasonably foreseen at the time of the execution of the agreement.  

**DATA PRIVACY and CONSENT**

DA5 and KabootekPH shall keep all DAPS Customer files in confidence in accordance with the Data Privacy Act of the Philippines. By providing the customer’s information for the purpose of availing a DAPS Wallet, he/she consents to the processing of his/her customer data, as may be applicable. 

**VENUE OF LITIGATION**

Venue of all suits shall be at Makati City.

**SEPARABILITY CLAUSE**

Should any term or condition in this Agreement be rendered invalid, the other provisions, insofar as they are separate from the invalid ones, shall remain in full force and effect. 

**CUSTOMER COMPLAINTS and INQUIRY**
For your information about how to contact Direct Agent 5, Inc., please visit https://da5.com.ph. You may likewise coordinate with our Customer Service Support Department at BSD - TECHSUPPORT <bsd.techsupport@da5.com.ph> and BSD - TECHSUPPORT bsd.techsupport@da5.com.ph / +632 8958195

**TERMS OF SERVICE USING THE DAPS APP**

There are lots of features the Daps app has to offer, and convenience is what it wants for its users. Here are the following features you can avail of through the Daps app. 

* **Send or Receive Money**

If you want to send money for your loved ones, the Daps app got you. It has lists of banks and remittance centers that you can set your transfer to. Likewise, receiving money is also one of the app’s features. Whatever transaction you want to make, make sure you got the right information to avoid the hassle. It would also be better to input your email address for your transaction receipt every time you send or receive money. 

* **Pay Bills**

Pay your utility bills through the Daps app. You just need to select the biller, input the amount, pay, and wait for the confirmation. From different utility and internet bills, you can use the app to clear your balance and avoid disconnection. You’ll see the lists of various billers such as:

* Electric utilities
* Water utilities
* Internet/Cable bills
* Telecoms bills
* Credit cards
* Government
* Loans
* Transportation
* Schools
* Real Estate
* Healthcare

  
* **Buy Load**

The Daps app can reload your prepaid and internet cards anytime. From the smallest to the highest possible eLoad amount, the Daps app got your back. Enter your mobile number, pay, and wait for confirmation. 
  
* **Purchase Online**

Shopping online for foods, clothes, furniture, and other essential products is made easier by the Daps app. Since it is an e-wallet, you can easily check out and pay for your due amount with just a tap. However, you need to link your Daps account to the store where you’ll purchase the product. This is where the linking of your debit card is essential. There are stores that don’t have the Daps app on their list of payment methods. In this case, you can still use the fund on the app by linking your card. It only takes a couple of steps to do that and you’re ready to shop securely with confidence.

* **QR Code**

The Daps app also generates QR codes if you want a seamless payment on the counter. It is helpful in stores that support payment through e-wallet.
  
* **CASH-IN THE DAPS ACCOUNT**

You may top up or load your Daps wallet either through mobile payment facilities available in the application or by going to Daps Partners Outlets like remittance centers, malls, and convenience stores. The minimum amount you can top up is Php 500.00. Once you have enough money in your wallet, you can start the mobile transactions you desire

* **LINKED BANK ACCOUNTS**

For faster transactions, you might need to link your bank account to the Daps app. Linking your credit and debit card is helpful, especially when you want to transfer money from the Daps app to your bank. Rest assured that your information is kept secured and confidential by the system. Here are the following bank accounts that you can link.

* American Express Virtual Pay
* Paypal
* BPI Account
* Any existing debit card you have

  
**Tips in using the Daps app**

* Never share nor store your Daps account and password to anyone or anywhere.
* If you are new to mobile wallets, start by cashing-in small amounts first until you get familiarized with the app and services the app offers.
* Always have a stable and secured internet connection when doing transactions on the Daps app.
* Do not get caught by phishing emails that contain malicious links that, when opened, the scammer can access your Daps account.

""";
