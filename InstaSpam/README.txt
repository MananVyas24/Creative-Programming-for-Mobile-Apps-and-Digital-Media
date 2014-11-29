In this folder you'll find the 3 stages of posting a photo to facebook. 

instaspam_editor_only : the image editor embedded in the browser

instaspam_post_to_php : the image editor with ability to save via PHP to the upload folder

instaspam_post_to_facebook : the image editor with post to facebook via PHP

--> to make it work properly with facebook:
** Remember to edit the app id in insta.js
** Remember to make the upload folder writeable by the web server (e.g. chmod 777)
** instaspam_post_to_facebook will only work if you put it on a publicly accessoble web server that can run PHP scripts. Also, you will need to put the address of this web server into the app config on your facebook developer page. 

--> To make a custom version:
* edit the source_code/InstaSpamFinal project in Processing/ javascript mode
* do an export.
* copy the InstaSpamFinal.pde file ONLY from the folder (plus image files if needed) and replace the old version of this file
