https://gist.github.com/rjhansen/67ab921ffb4084c865b3618d6955275f

Executive Summary
In the last week of June 2019 unknown actors deployed a certificate spamming attack against two high-profile contributors in the OpenPGP community (Robert J. Hansen and Daniel Kahn Gillmor, better known in the community as "rjh" and "dkg"). This attack exploited a defect in the OpenPGP protocol itself in order to "poison" rjh and dkg's OpenPGP certificates. Anyone who attempts to import a poisoned certificate into a vulnerable OpenPGP installation will very likely break their installation in hard-to-debug ways. Poisoned certificates are already on the SKS keyserver network. There is no reason to believe the attacker will stop at just poisoning two certificates. Further, given the ease of the attack and the highly publicized success of the attack, it is prudent to believe other certificates will soon be poisoned.

This attack cannot be mitigated by the SKS keyserver network in any reasonable time period. It is unlikely to be mitigated by the OpenPGP Working Group in any reasonable time period. Future releases of OpenPGP software will likely have some sort of mitigation, but there is no time frame. The best mitigation that can be applied at present is simple: stop retrieving data from the SKS keyserver network.