Redmine Shady
=============

Redmine plugin allowing to temporarily disable sending e-mail notifications
triggered by user.


Installation
------------

Follow standard Redmine plugin installation procedure.

  * Move `redmine_shady/` to `$REDMINE/plugins/`.


Configuration
-------------

 * Set "Use Shady Mode" permission for roles.

    Authorized users will be able to temporarily disable sending notifications
    triggered by his action by clicking "Shady Mode" in account menu.


Requirements
------------

Since this program depend on another software, it was written with compatibility
in mind to keep it functional across many version of software it uses.

  * Redmine (2.0+)
