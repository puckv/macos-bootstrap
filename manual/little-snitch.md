# Little Snitch

[Download](https://www.obdev.at/products/littlesnitch/download.html) and check integrity before installing.

```bash
codesign -v --verify -R="anchor apple generic and certificate leaf[subject.OU] = MLZF7K7B5R" ~/Downloads/LittleSnitch*.dmg
```

Install. Restart will be required.
* Configure in Alert mode

**Preferences:**

* Alert
    * Preselected options:
        * Duration: _15 minutes_
        * Port and protocol: _Specific_
    * **Disable:** _Confirm with Return and Escape_
    * Detail Level: _Show Port and Protocol Details_
* Monitor
    * _Show data rates as numerical values_
    * _Show Helper XPC Processes_
* Security
    * _Allow global rule editing*
    * **Disable:** _Respect privacy of other users_ 
    * **Disable:** _Ignore code signature for local network connections_
* Advanced
    * _Mark new rules as unapproved_
    * **Disable:** _Approve rules automatically_
    
**Rules:**

* Subscribe to [rule groups](https://github.com/puckv/lsrules) (all or selected)

* Factory Rules: **Disable** all factory rules
* If enabled, disable subscriptions to both rule groups as well as individual rules inside groups (they might be active even if subscription is inactive) 
    * iCloud Services
    * macOS Services
