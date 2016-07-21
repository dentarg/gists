From https://www.defensivesecurity.org/defensive-security-podcast-episode-162/#comment-206

2 thoughts on “Defensive Security Podcast Episode 162”

cr43t4n June 7, 2016 at 6:16 am

I listened to your comments on SWIFT and will offer some clarification of the SWIFT system and the nature of the breaches.

The SWIFT system is essentially a store-and-forward messaging conceived to replace the Telex that most banks originally used. One requirement was that the receiving bank be able to verify the origin and authenticity of any message; because of the automated trading that takes place it is essential that you can trust the content. Messages created by the gateway (SAG) or Swift Alliance Access (SAA) platforms are digitally signed to allow verification of content and non-repudiation of origin. The digital signatures (PKI) are usually generated in a HSM (Hardware Security Module) in which the digital key and certificate reside. Originally the key system was based on BKE (Bilateral Key Exchange) which required a bank to certify which organisations it would exchange messages with. SWIFT replaced the BKE system with a PKI based solution in 2009 and added a relationship management function to replace the BKE agreement. The keys are used to authenticate messages by combining them into a Message Authentication Code (MAC) embedded in the message.

These mechanisms allow organisations to automatically verify the authenticity of a SWIFT message and if the origin organisation is someone they agree to do business with. These mechanisms effectively prevent forged messages from being accepted by the system.

The issue was always that if the bank did not secure the SWIFT terminals/gateways then attackers could either physically or remotely gain the credentials necessary to create and then authorise transactions. There have been many “heists” in the past, prior to the ones in the news, where the attackers planted key loggers to collect the credentials or compromised an employee to get access. Previously this was always considered to be an issue for the bank, not SWIFT as the limit of liability was always the VPN router that connects the bank infrastructure to SWIFT. Most breaches are a result of inadequate infrastructure and/or controls inside the institutions. Despite all of the high profile cases the control frameworks and compliance/governance remain rooted in the old financial world

What can you take away from the recent breaches?
The attackers were present in the back office networks for an extended period and were able to gain all of the necessary authorisation credentials to make transfers. The sophistication of the attackers is apparent by there ability to manipulate the SWIFT software and there apparent knowledge of how SWIFT and the financial systems works.

Can we fix it or prevent it happening?
The current SAA supports two factor authentication via a radius server which would allow mitigation of some of the attacks seen recently. Another obvious solution would be to segregate all of the SWIFT systems from the back office network and enforce tight control over who has access and from where. The use of FIM (File Integrity Monitoring) on the messaging platforms would detect unauthorised modifications.

One challenge with patching the platforms (which is an essential activity in the vulnerability management space) on which the SWIFT software runs is that there (SWIFT) support contract mandates that the version used have to be in there catalog. These are inevitably behind the curve when it comes to patching. This makes the platforms potentially vulnerable to exploitation in the name of support (way to go!).

If you are responsible for security ask yourself the question; are we exposed to threats to our reputation or financial viability by the failings of our suppliers or services built on other peoples services? What would you do if this happened to you?

Log in to Reply
jb June 7, 2016 at 6:22 am
Thank you for the thoughtful and thorough explanation. That was very helpful in understanding the landscape of these attacks.

Log in to Reply
