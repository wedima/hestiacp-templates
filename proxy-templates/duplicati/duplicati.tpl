#=======================================================================#
# Duplicati Template                                                    #
#=======================================================================#

server {
    listen      %ip%:%web_port%;
    server_name %domain_idn% %alias_idn%;
    root        %docroot%;
    index       index.php index.html index.htm;
    access_log  /var/log/nginx/domains/%domain%.log combined;
    access_log  /var/log/nginx/domains/%domain%.bytes bytes;
    error_log   /var/log/nginx/domains/%domain%.error.log error;

    include %home%/%user%/conf/web/%domain%/nginx.forcessl.conf*;

    location / {
        auth_basic "Restricted";
        auth_basic_user_file %home%/%user%/conf/web/%domain%/htpasswd;
        proxy_pass http://127.0.0.1:8200;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for
    }

    include     %home%/%user%/conf/web/%domain%/nginx.conf_*;
}
