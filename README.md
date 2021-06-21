# GTM Consent Listener
This is a custom tag template for Google Tag Manager for the web.  
In GTM's consent mode, a custom event is generated when the status of each type changes.

## Usage
Register it as a tag and set the "**Initialization - All Pages**" trigger to the delivery trigger.  
After the tag fires, when the status of the consent type changes on the page, a custom event will be fired, once for each consent type.

By registering these custom events as **custom event trigger**s, you will be able to fire any tag when any consent type changes.

### Example
The custom event that fires is the name of the "**consent type name + _on/_off**" that changed the status.

#### ad_storage: off -> on
{{event}} = **ad_storage_on**

#### ad_storage: on -> off
{{event}} = **ad_storage_off**

## Note
- Custom consent types other than the default five consent types can also be included in the tag.  
  However, in this case, **you need to add the custom consent type you want to retrieve to the access_consent permission of the template with read permission**.

