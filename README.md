Week 3 Project: Dealing with Toil at UpCommerce
===

Task 1
---

Solution can be found in the [watcher.sh](watcher.sh) file.

Task 2
---

> Identify potential solutions or products, whether free or commercial, to address the toil in the ticketing system. These solutions should aim to mitigate issues such as recurring obsolete alerts and lack of prioritization.

Tools can support reducing toil in the ticketing systems by providing the following features:
* **Pre-defined error or warning levels**. Ticket systems will be able to track issues of the systems according to their severity level and support prioritizations (or escalations) accordingly. This significantly reduces the amount of false alerts and allows SREs to concentrate on fixing the most important issues first.
* **Tracking alerts that have already been sent out**. Intelligent systems can track whether tickets have already been created for a given issue (e.g. based on the error title or unique identifiers or even by using AI-based categorization). This reduces the amount of duplicates in the ticketing system and allows for better escalation management in case the issue/error was worth an alert and resultion times are stacking up.

Examples for those systems are:
* **Pre-defined error or warning levels**: Google Cloud Error or code-based logging systems (e.g. Log4J) in combination with log ingestion systems (e.g. Google Cloud Logging, Splunk, logstash etc.)
* **Tracking alerts that have already been sent out**: Google Cloud Error together with Google Cloud Monitoring & Alerting, Pagerduty