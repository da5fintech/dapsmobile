import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

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
        body: Markdown(data: type == 'terms' ? terms : ""),
      )
    );
  }
}

const privacy = """
**Privacy Policy**

Jose Paulo M. Dela Cruz built the Sari Sales app as a Commercial app. This SERVICE is provided by Jose Paulo M. Dela Cruz and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Sari Sales unless otherwise defined in this Privacy Policy.

**Information Collection and Use**

For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Mobile Point of sales. The information that I request will be retained on your device and is not collected by me in any way.

The app does use third party services that may collect information used to identify you.

Link to privacy policy of third party service providers used by the app

*   [Google Analytics for Firebase](https://firebase.google.com/policies/analytics)
*   [Firebase Crashlytics](https://firebase.google.com/support/privacy/)
*   [Facebook](https://www.facebook.com/about/privacy/update/printable)

**Log Data**

I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

**Cookies**

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.
This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

**Service Providers**

I may employ third-party companies and individuals due to the following reasons:
*   To facilitate our Service;
*   To provide the Service on our behalf;
*   To perform Service-related services; or
*   To assist us in analyzing how our Service is used.

I want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

**Security**

I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

**Links to Other Sites**

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

**Children’s Privacy**

These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13\. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do necessary actions.

**Changes to This Privacy Policy**

I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2020-06-06

**Contact Us**

If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at jeypsdelacruz.com.

""";


const terms = """
**TERMS AND CONDITIONS**

Welcome to the Swipe Application. This Application is provided by Direct Agent 5 and KabootekPH Inc. By registering/using to our service, you agree to the terms and conditions contained in this Terms of Service as well as additional terms and conditions which may subsequently apply to you. Please read them carefully. The following T&Cs shall govern the terms under which you may access and use the products of Swipe and the services associated with it.  
Swipe reserves the right to modify these T&Cs at any time without any advance notice. Any changes to these T&Cs will be effective immediately upon posting on this page, with an updated effective date. 

**TERMS**

Direct Agent 5, Inc. – A company duly registered with the Bangko Sentral ng Pilipinas (BSP) as a licensed remittance agent. It offers cash in and cash out services, mobile air-time top ups, remittance services, bill payments and Virtual Currency exchange (hereinafter “DA5 Services”
Kabootekph- A company duly registered with the Bangko Sentral ng Pilipinas (BSP) acting as a partner of Direct Agent 5 in providing………..
“Know Your Customer” or “KYC” shall refer to the process of verifying the identity of the customer as required by the BSP.
“Mobile Personal Identification Number” or “MPIN” shall refer to the four (4)-digit security personal identification number of, and nominated for the Swipe Customer that is used for all Swipe transactions. 
Online Payments – Refers to the payment made by an online merchant over the internet. 
Swipe App - the Swipe Service application running on mobile devices where the customer can avail of the Swipe Services or make use of the Swipe Wallet.
Swipe Wallet – An e-money instrument that is used, but are not limited to, payments of goods and services, transfer funds and mobile airtime top-ups. It is not a deposit account, and not covered by the Philippine Deposit Insurance Corporation (PDIC). It does not earn interest.

**REGISTRATION FOR A SWIPE ACCOUNT**

You will be asked to provide information such as your complete name, address, date of birth, nationality, source of funds, Identification Card as provided below, in accordance with the requirements of Know-Your-Customer (“KYC”) requirements of the BSP. By accepting this terms and conditions, you are agreeing to provide necessary information for registration and verification of your identification details. Likewise, we may require you to provide additional details or information for further verification of your identity.

**VERIFICATION FOR A SWIPE ACCOUNT**

To verify your identity, you will be asked to submit a clear photo of your valid identification card. Make sure to take a photo of your ID showing your face and your signature. Failure to submit clear images will result in to delay in your verification. 
The following are the identification cards Swipe app accepts:

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


DA5 and KabootekPh reserve the right to terminate, suspend or limit your access to your Swipe Wallet and/or Services in the event that we are unable to obtain or verify our information. All collection and use of your personal data by us is subject to the Data Privacy Act of the Philippines.

**WARRANTIES AND DISCLAIMER** 

DA5 and KabootekPh provide its Services using a commercially reasonable level of skill and care for the provision of efficient assistance in respect of your payment transactions. Other than as expressly set out herein or under additional terms as may be subsequently stipulated by Swipe Terms and Conditions and to the extent permitted by the law. Swipe does not make any warranty about our service which is provided “as is”. 

**LIABILITY FOR OUR SERVICE**

To the extent permitted by the Law, Swipe App shall not be responsible for lost profits, revenue, data financial loss or any indirect special, consequential, exemplary or punitive damages arising from the use of the Swipe Application. The total liability which Swipe may be held in accountable relative to any claims under this Agreement shall be limited to the relevant transaction amount paid to us using the online bills pay service. 
In no case shall DA5 be liable for any loss or damage resulting from force majeure or any circumstances which is beyond the reasonable contemplation and control of DA5 and KabootekPH and totally independent of the will of the human beings, the consequences of which could not be reasonably foreseen at the time of the execution of the agreement.  

**DATA PRIVACY and CONSENT**

DA5 and KabootekPH shall keep all SWIPE Customer files in confidence in accordance with the Data Privacy Act of the Philippines. By providing the customer’s information for the purpose of availing a SWIPE Wallet, he/she consents to the processing of his/her customer data, as may be applicable. 

**VENUE OF LITIGATION**

Venue of all suits shall be at Makati City.

**SEPARABILITY CLAUSE**

Should any term or condition in this Agreement be rendered invalid, the other provisions, insofar as they are separate from the invalid ones, shall remain in full force and effect. 

**CUSTOMER COMPLAINTS and INQUIRY**
For your information about how to contact Direct Agent 5, Inc., please visit https://da5.com.ph. You may likewise coordinate with our Customer Service Support Department at BSD - TECHSUPPORT <bsd.techsupport@da5.com.ph> and BSD - TECHSUPPORT bsd.techsupport@da5.com.ph / +632 8958195

**TERMS OF SERVICE USING THE SWIPE APP**

There are lots of features the Swipe app has to offer, and convenience is what it wants for its users. Here are the following features you can avail of through the Swipe app. 

* **Send or Receive Money**

If you want to send money for your loved ones, the Swipe app got you. It has lists of banks and remittance centers that you can set your transfer to. Likewise, receiving money is also one of the app’s features. Whatever transaction you want to make, make sure you got the right information to avoid the hassle. It would also be better to input your email address for your transaction receipt every time you send or receive money. 

* **Pay Bills**

Pay your utility bills through the Swipe app. You just need to select the biller, input the amount, pay, and wait for the confirmation. From different utility and internet bills, you can use the app to clear your balance and avoid disconnection. You’ll see the lists of various billers such as:

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

The Swipe app can reload your prepaid and internet cards anytime. From the smallest to the highest possible eLoad amount, the Swipe app got your back. Enter your mobile number, pay, and wait for confirmation. 
  
* **Purchase Online**

Shopping online for foods, clothes, furniture, and other essential products is made easier by the Swipe app. Since it is an e-wallet, you can easily check out and pay for your due amount with just a tap. However, you need to link your Swipe account to the store where you’ll purchase the product. This is where the linking of your debit card is essential. There are stores that don’t have the Swipe app on their list of payment methods. In this case, you can still use the fund on the app by linking your card. It only takes a couple of steps to do that and you’re ready to shop securely with confidence.

* **QR Code**

The Swipe app also generates QR codes if you want a seamless payment on the counter. It is helpful in stores that support payment through e-wallet.
  
* **CASH-IN THE SWIPE ACCOUNT**

You may top up or load your Swipe wallet either through mobile payment facilities available in the application or by going to Swipe Partners Outlets like remittance centers, malls, and convenience stores. The minimum amount you can top up is Php 500.00. Once you have enough money in your wallet, you can start the mobile transactions you desire

* **LINKED BANK ACCOUNTS**

For faster transactions, you might need to link your bank account to the Swipe app. Linking your credit and debit card is helpful, especially when you want to transfer money from the Swipe app to your bank. Rest assured that your information is kept secured and confidential by the system. Here are the following bank accounts that you can link.

* American Express Virtual Pay
* Paypal
* BPI Account
* Any existing debit card you have

  
**Tips in using the Swipe app**

* Never share nor store your Swipe account and password to anyone or anywhere.
* If you are new to mobile wallets, start by cashing-in small amounts first until you get familiarized with the app and services the app offers.
* Always have a stable and secured internet connection when doing transactions on the Swipe app.
* Do not get caught by phishing emails that contain malicious links that, when opened, the scammer can access your Swipe account.

""";
