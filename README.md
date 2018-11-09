# ABAP-SAPLink-Plugins

## What is SAPLink?

SAPlink is a project that aims to make it easier to share ABAP developments between programmers. It provides the ability to easily distribute and package custom objects.

https://app.assembla.com/spaces/saplink/wiki

## What are the SAPLink Plugins?

The SAPLink Plugins are addons to handle a specific SAP Object (Example: Search Help).

https://app.assembla.com/spaces/saplink/wiki/SAPlink_plugin_list

## What plugins are here?

**ZSAPLINK_STANDARD_TEXTS**

Plugin to use Standard Texts. This objects are created with SO10 Transaction, SAVE_TEXT Function Module or another solution (Example: Text object in a document)

The object name must have this format: TDOBJECT,TDNAME,TDID,TDSPRAS

Example: TEXT,YBCTESTHTML,ST,E

**ZSAPLINK_TRANSACTIONS**

Plugin to use Transactions Codes. This object are created with SE93 Transaction using the same Function Modules like SAP.

Is out of the scope the Authorization Object configuration.

## How to install it?

Download the nugget, and import it with SAPLink.

![Nugget IMport](http://rene.turnheim.com/wp/wp-content/uploads/2013/09/ZSAPLINK.png)
