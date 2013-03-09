ReadMe for our AddressBook App

1.cd to Task1/ dir and enter the command:
  python manage.py runserver
2.Open any browser and enter the following url:
  localhost:8000/addressBook/
3.You are now in Login, register page follow the instructions
4.You should now be in home page now you can add a new contact or view current contacts for further actions
  you have to view Contacts => then click a contact name to display his detail page.
5. If you wish to interact with the database directly enter the following commands while in Task1/
  python mange.py shell
  >>>User.objects.all()
  >>>User.objects.all()[0].contact_set.all()
  >>>User.objects.all()[0].contact_set.all().[0].field_set()[0]
6. The above only works if you already created a user with at least one contact with a custom field.
7.Many other actions are possible check django docs on ORM for more info :D have fun.

