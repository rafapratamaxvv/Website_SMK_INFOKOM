Panel admin ditangani oleh controllers/ (AuthController, AdminController, CrudController, dll.)
dan views/admin/. URL: /admin/login dan /admin/dashboard. Folder ini sengaja tanpa file PHP
agar seluruh akses admin melewati router + middleware (AuthMw/PermMw/RoleMw).

Login admin
Username: admin@smkinfokom.local
Password: smkinfkmbgr26
